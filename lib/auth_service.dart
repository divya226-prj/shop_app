import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign up new user
  Future<String?> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // Save username to Firestore
      await _db.collection('users').doc(userCredential.user!.uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'uid': userCredential.user!.uid,
      });

      return null; // success
    } catch (e) {
      return e.toString(); // return error message
    }
  }

  // Login existing user
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Logout user
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Check current user
  User? get currentUser => _auth.currentUser;
}
