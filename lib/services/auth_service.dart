import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      print("Sign in error: $e");
      return null;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
    String username,
    String contact,
    String address,
    String pincode,
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('Users').doc(result.user!.uid).set({
        'name': username,
        'contact': contact,
        'address': address,
        'pin code': pincode,
        'email': email,
        'password': password,
        'createdAt': Timestamp.now(),
      });
      return result;
    } catch (e) {
      print("Registration error: $e");
      return null;
    }
  }

  // Future<void> signOut() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (e) {
  //     print("Sign out error: $e");
  //   }
  // }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
