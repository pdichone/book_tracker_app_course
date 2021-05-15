import 'package:book_tracker/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchdBookDetailDialog extends StatelessWidget {
  const SearchdBookDetailDialog({
    Key key,
    @required this.book,
    @required CollectionReference<Map<String, dynamic>> bookCollectionReference,
  }) : _bookCollectionReference = bookCollectionReference, super(key: key);

  final Book book;
  final CollectionReference<Map<String, dynamic>> _bookCollectionReference;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(book.photoUrl),
              radius: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Category: ${book.title}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Page Count: ${book.pageCount}',
            ),
          ),
          Text('Author: ${book.author}'),
          Text('Published: ${book.publishedDate}'),
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueGrey.shade100,
                    width: 1)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  book.description,
                  style: TextStyle(
                      wordSpacing: 0.9, letterSpacing: 1.5),
                ),
              ),
            ),
          ))
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                _bookCollectionReference.add(Book(
                        userId: FirebaseAuth
                            .instance.currentUser.uid,
                        title: book.title,
                        author: book.author,
                        photoUrl: book.photoUrl,
                        publishedDate: book.publishedDate,
                        description: book.description,
                        pageCount: book.pageCount,
                        categories: book.categories)
                    .toMap());
                Navigator.of(context).pop();
              },
              child: Text('Save')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
        )
      ],
    );
  }
}
