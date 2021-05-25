import 'dart:convert';

import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:book_tracker/widgets/searched_book_detail_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  TextEditingController _searchTextController;

  List<Book> listOfBooks = [];
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.redAccent,
      ),
      body: Material(
        elevation: 0.0,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: TextField(
                      onSubmitted: (value) {
                        _search();
                      },
                      controller: _searchTextController,
                      decoration: buildInputDecoration(
                          label: 'Search', hintText: 'Flutter Development'),
                    )),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                (listOfBooks != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: 300,
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: createBookCards(listOfBooks, context),
                            ),
                          )),
                        ],
                      )
                    : Center(
                        child: Text(''),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    await fetchBooks(_searchTextController.text).then((value) {
      setState(() {
        listOfBooks = value;
      });
    }, onError: (val) {
      throw Exception('Failed to load books ${val.toString()}');
    });
  }

  Future<List<Book>> fetchBooks(String query) async {
    List<Book> books = [];
    http.Response response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final Iterable list = body['items'];
      for (var item in list) {
        String title = item['volumeInfo']['title'];
        String author = item['volumeInfo']['authors'] == null
            ? "N/A"
            : item['volumeInfo']['authors'][0];
        String thumbNail = (item['volumeInfo']['imageLinks'] == null)
            ? ""
            : item['volumeInfo']['imageLinks']['thumbnail'];
        String publishedDate = item['volumeInfo']['publishedDate'] == null
            ? "N/A"
            : item['volumeInfo']['publishedDate'];
        String description = item['volumeInfo']['description'] == null
            ? "N/A"
            : item['volumeInfo']['description'];
        int pageCount = item['volumeInfo']['pageCount'] == null
            ? 0
            : item['volumeInfo']['pageCount'];
        String categories = item['volumeInfo']['categories'] == null
            ? "N/A"
            : item['volumeInfo']['categories'][0];

        Book searchedBook = new Book(
            title: title,
            author: author,
            photoUrl: thumbNail,
            description: description,
            publishedDate: publishedDate,
            pageCount: pageCount,
            categories: categories);

        books.add(searchedBook);

        // print('${item['volumeInfo']['title']}');
      }
    } else {
      throw ('error ${response.reasonPhrase}');
    }
    return books;
  }

  List<Widget> createBookCards(List<Book> books, BuildContext context) {
    List<Widget> children = [];
    final _bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
    for (var book in books) {
      children.add(Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Card(
          elevation: 5,
          color: Color(0xfff6f4ff),
          child: Wrap(
            children: [
              Image.network(
                (book.photoUrl == null || book.photoUrl.isEmpty)
                    ? 'https://images.unsplash.com/photo-1553729784-e91953dec042?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80'
                    : book.photoUrl,
                height: 100,
                width: 160,
              ),
              ListTile(
                title: Text(
                  book.title,
                  style: TextStyle(color: Color(0xff5d48b6)),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  book.author,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SearchdBookDetailDialog(
                          book: book,
                          bookCollectionReference: _bookCollectionReference);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ));
    }
    return children;
  }
}
