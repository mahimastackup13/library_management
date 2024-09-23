// import 'dart:convert';

class Book {
  static final Set<String> _usedIsbns = {}; 
  String title;
  String author;
  dynamic year;
  String genre;
  String isbn;
  bool isLent;
  String? lentTo;
  DateTime? dueDate;

  Book({
    required this.title,
    required this.author,
    required this.year,
    required this.genre,
    required String isbn, 
    this.isLent = false,
    this.lentTo,
    this.dueDate,
  }) : this.isbn = _validateAndAddIsbn(isbn);
  
  static String _validateAndAddIsbn(String isbn) {
    if (_usedIsbns.contains(isbn)) {
      throw ArgumentError('ISBN must be unique.');
    }
    _usedIsbns.add(isbn);
    return isbn;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'year': year,
        'genre': genre,
        'isbn': isbn,
        'isLent': isLent,
        'lentTo': lentTo,
        'dueDate': dueDate?.toIso8601String(),
      };
      

  static Book fromJson(Map<String, dynamic> json) {
    final bookData = json['data'] ?? json;

  try {
      return Book(
        title: bookData['title'] ?? 'Unknown Title',
        author: bookData['author'] ?? 'Unknown Author',
        year: bookData['year'] ?? 'Unknown Year',
        genre: bookData['genre'] ?? 'Unknown Genre',
        isbn: bookData['isbn']?.toString() ?? 'Unknown ISBN',
        isLent: bookData['isLent'] ?? false,
        lentTo: bookData['lentTo'],
        dueDate: bookData['dueDate'] != null ? DateTime.tryParse(bookData['dueDate']) : null,
      );
    } catch (e) {
      print('Error parsing book: $e. Data: $bookData');
      throw e; // Propagate the error for handling in loadData
    }
  }

  @override
  String toString() {
    return 'Title: $title, Author: $author, Year: $year, Genre: $genre, ISBN: $isbn, Lent: $isLent';
  }
}




