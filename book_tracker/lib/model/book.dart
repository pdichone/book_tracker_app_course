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

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
        id: data['id'],
        title: data['title'],
        author: data['author'],
        notes: data['notes'],
        photoUrl: data['photo_url'],
        categories: data['categories'],
        publishedDate: data['published_date'],
        description: data['description'],
        pageCount: data['page_count'],
        userId: data['user_id']);
  }
}
