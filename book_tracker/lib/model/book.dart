import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String notes;
  final String photoUrl;
  final String categories;
  final String publishedDate;
  final String description;
  final int pageCount;
  final String userId;

  Book({
    this.id,
    this.title,
    this.author,
    this.notes,
    this.photoUrl,
    this.categories,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.userId,
  });

  factory Book.fromDocument(QueryDocumentSnapshot data) {
    Map<String, dynamic> info = data.data();
    return Book(
        id: data.id,
        title: info['title'],
        author: info['author'],
        notes: info['notes'],
        photoUrl: info['photo_url'],
        categories: info['categories'],
        publishedDate: info['published_date'],
        description: info['description'],
        pageCount: info['page_count'],
        userId: info['user_id']);
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userId,
      'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      'description': description,
      'page_count': pageCount,
      'categories': categories,
    };
  }
}
