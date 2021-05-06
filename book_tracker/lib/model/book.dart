class Book {
  final String id;
  final String title;
  final String author;
  final String notes;
  final String categories;
  final String description;

  Book(
      {this.id,
      this.title,
      this.author,
      this.notes,
      this.categories,
      this.description});

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
        id: data['id'],
        title: data['title'],
        author: data['author'],
        notes: data['notes'],
        categories: data['categories'],
        description: data['description']);
  }
}
