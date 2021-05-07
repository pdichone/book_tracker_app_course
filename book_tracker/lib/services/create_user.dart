import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(String displayName, BuildContext context) async {
  final userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid;

  Map<String, dynamic> user = {
    'avatar_url': null,
    'display_name': displayName,
    'profession': 'nope',
    'quote': 'Life is great',
    'uid': uid
  };
  userCollectionReference.add(user);
}
