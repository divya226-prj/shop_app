import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApplicationProvider extends ChangeNotifier {
  String username = '';
  String email = '';
  String profilePhoto = '';

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data();

    if (data != null) {
      username = data['username'] ?? '';
      email = data['email'] ?? '';
      profilePhoto = data['profilePhoto'] ?? '';
      notifyListeners();
    }
  }
}
