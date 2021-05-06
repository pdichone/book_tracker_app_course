import 'package:book_tracker/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference booksCollection =
        FirebaseFirestore.instance.collection('books');
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
            StreamBuilder<QuerySnapshot>(
              stream: booksCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final bookListStream = snapshot.data.docs.map((book) {
                  return Book.fromMap(book.data());
                }).toList();
                //Map<String, dynamic> data = snapshot.data.docs.first.data();
                Book book = bookListStream[0];

                return Text(book.author, style: TextStyle(color: Colors.black));
              },
            )
          ],
        ),
      ),
    );
  }
}
