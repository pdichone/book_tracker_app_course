import 'dart:convert';

import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookSearchPage extends StatelessWidget {
  final TextEditingController _searchTextController = TextEditingController();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    print('calling search...');
    await fetchBooks(_searchTextController.text).then((value) {
      print('calling fetchBooks');
      for (var item in value) {
        print(item.author);
      }
      return null;
    }, onError: (val) {
      throw Exception('Failed to load books ${val.toString()}');
    });
  }

// var escapeJSON = function(str) {
//     return str.replace('/\\/g',"\\");
// };
  Future<List<Book>> fetchBooks(String query) async {
    List<Book> books = [];
    http.Response response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

    print('$query');
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
}
