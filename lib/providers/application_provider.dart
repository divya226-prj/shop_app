import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApplicationProvider extends ChangeNotifier {
  Stream<DocumentSnapshot> get userStream {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
  }

  Future<void> updateUserField(String fieldName, String value) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      fieldName: value,
    });
  }
}
