import 'package:book_tracker/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/1/200/300'),
                      backgroundColor: Colors.white,
                      child: Text(''),
                    ),
                  ),
                  Text(
                    'UserName',
                    style: TextStyle(color: Colors.black12),
                  )
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {}, icon: Icon(Icons.logout), label: Text(''))
        ],
      ),
    );
  }
}
