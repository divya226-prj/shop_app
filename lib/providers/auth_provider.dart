import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  User? user;
  AuthProvider() {
    user = _auth.currentUser;
  }
  Future<void> userDetails(
    dynamic firebaseUser, {
    required String? email,
  }) async {
    final doc = await _firestore
        .collection('users')
        .doc(firebaseUser?.uid)
        .get();
    if (!doc.exists) {
      await _firestore.collection('users').doc(firebaseUser?.uid).set({
        'uid': firebaseUser?.uid,
        'email': email,
        'username': firebaseUser?.displayName ?? 'Guest',
        'createdAt': DateTime.now(),
      });
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login(
        loginBehavior: LoginBehavior.nativeWithFallback,
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString ?? "",
        );

        final userCred = await _auth.signInWithCredential(credential);
        final User? firebaseUser = userCred.user;
        final facebookUserData = await _facebookAuth.getUserData();

        userDetails(
          firebaseUser,
          email:
              facebookUserData["email"] ??
              firebaseUser?.email ??
              'Add your email',
        );
        return "success";
      } else if (result.status == LoginStatus.cancelled) {
        return "Facebook login cancelled";
      } else {
        print(result.message);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<String?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return "Sign in cancelled";
      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCred = await _auth.signInWithCredential(cred);
      final User? firebaseUser = userCred.user;

      userDetails(firebaseUser, email: firebaseUser?.email ?? googleUser.email);
      return null;
    } catch (e) {
      print(e.toString());
    }
    return "Google Sign in failed";
  }

  Future<String?> signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCred.user;

      // final doc = await _firestore.collection('users').doc(user?.uid).get();

      userDetails(firebaseUser, email: firebaseUser?.email ?? 'Add your email');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    await _facebookAuth.logOut();
  }
}
