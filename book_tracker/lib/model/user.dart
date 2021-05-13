import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MUser {
  final String id;
  final String uid;
  final String displayName;
  final String quote;
  final String profession;
  final String avatarUrl;

  MUser(
      {this.id,
      this.uid,
      @required this.displayName,
      this.quote,
      this.profession,
      this.avatarUrl});

  factory MUser.fromDocument(QueryDocumentSnapshot data) {
    Map<String, dynamic> info = data.data();
    return MUser(
      id: data.id,
      uid: info['uid'],
      displayName: info['display_name'],
      quote: info['quote'],
      profession: info['profession'],
      avatarUrl: info['avatar_url'],
    );
  }

 

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'display_name': displayName,
      'quote': quote,
      'profession': profession,
      'avatar_url': avatarUrl,
    };
  }
}
