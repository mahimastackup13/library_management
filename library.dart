import 'dart:io'; 
import 'library_api.dart';
import 'books.dart';
import 'author.dart';
import 'member.dart';

class LibraryManager {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];

  final DataPersistence dataPersistence; // Link the DataPersistence instance

  LibraryManager(this.dataPersistence);

  // Book Methods
  Future<void> loadBooks() async {
    books = await dataPersistence.getBooks(); // Fetch existing books from the API
  }

  Future<void> addBook() async {
    try {
      final title = _getValidInput('Enter book title: ');
      final author = _getValidInput('Enter author: ');
      final year = _getValidIntInput('Enter publication year: ');
      final genre = _getValidInput('Enter genre: ');
      final isbn = _getValidInput('Enter ISBN: ');

      final newBook = Book(
        title: title,
        author: author,
        year: year,
        genre: genre,
        isbn: isbn,
      );

      books.add(newBook);
      await dataPersistence.saveBook(newBook); // Save book using the API
      print('Book added successfully.');
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  void viewBooks() {
    if (books.isEmpty) {
      print('No books available.');
    } else {
      for (var book in books) {
        print(book);
      }
    }
  }

  Future<void> updateBook(String isbn) async {
    try {
      final book = books.firstWhere((b) => b.isbn == isbn,
          orElse: () => throw Exception('Book not found.'));
      stdout.write('Enter new title (leave empty to keep unchanged): ');
      final title = stdin.readLineSync();
      stdout.write('Enter new author (leave empty to keep unchanged): ');
      final author = stdin.readLineSync();
      stdout.write('Enter new publication year (leave empty to keep unchanged): ');
      final yearInput = stdin.readLineSync();
      stdout.write('Enter new genre (leave empty to keep unchanged): ');
      final genre = stdin.readLineSync();

      if (title != null && title.isNotEmpty) book.title = title;
      if (author != null && author.isNotEmpty) book.author = author;
      if (yearInput != null && yearInput.isNotEmpty) book.year = int.parse(yearInput);
      if (genre != null && genre.isNotEmpty) book.genre = genre;

      await dataPersistence.updateBook(isbn, book); // Update the book via API
      print('Book updated.');
    } catch (e) {
      print('Error updating book: $e');
    }
  }

  Future<void> deleteBook(String isbn) async {
    try {
      books.removeWhere((b) => b.isbn == isbn);
      await dataPersistence.deleteBook(isbn); // Delete book via API
      print('Book deleted.');
    } catch (e) {
      print('Error deleting book: $e');
    }
  }

  void searchBooks(String query) {
    final results = books.where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase()) ||
        book.author.toLowerCase().contains(query.toLowerCase()) ||
        book.genre.toLowerCase().contains(query.toLowerCase()));

    if (results.isEmpty) {
      print('No books found.');
    } else {
      for (var book in results) {
        print(book);
      }
    }
  }

  // Author Methods
  Future<void> addAuthor() async {
    try {
      final name = _getValidInput('Enter author name: ');
      final dob = _getValidDateInput('Enter author date of birth (YYYY-MM-DD): ');
      stdout.write('Enter books written by author (comma-separated): ');
      final booksWritten = stdin.readLineSync()!.split(',').map((b) => b.trim()).toList();

      final newAuthor = Author(name: name, dob: dob, booksWritten: booksWritten);

      if (authors.any((a) => a.name == newAuthor.name && a.dob == newAuthor.dob)) {
        print('An author with the same name and DOB already exists.');
        return;
      }
      authors.add(newAuthor);
      await dataPersistence.saveAuthor(newAuthor); // Save author via API
      print('Author added successfully.');
    } catch (e) {
      print('Error adding author: $e');
    }
  }

  Future<void> updateAuthor(String name) async {
    try {
      final author = authors.firstWhere((a) => a.name == name,
          orElse: () => throw Exception('Author not found.'));
      stdout.write('Enter new name (leave empty to keep unchanged): ');
      final newName = stdin.readLineSync();
      stdout.write('Enter new date of birth (leave empty to keep unchanged): ');
      final dobInput = stdin.readLineSync();
      stdout.write('Enter new books written (leave empty to keep unchanged): ');
      final booksInput = stdin.readLineSync();

      if (newName != null && newName.isNotEmpty) author.name = newName;
      if (dobInput != null && dobInput.isNotEmpty) author.dob = DateTime.parse(dobInput);
      if (booksInput != null && booksInput.isNotEmpty) {
        author.booksWritten = booksInput.split(',').map((b) => b.trim()).toList();
      }

      await dataPersistence.updateAuthor(author.id, author); 
      print('Author updated.');
    } catch (e) {
      print('Error updating author: $e');
    }
  }

  Future<void> deleteAuthor(String name) async {
    try {
      authors.removeWhere((a) => a.name == name);
      await dataPersistence.deleteAuthor(name); 
      print('Author deleted.');
    } catch (e) {
      print('Error deleting author: $e');
    }
  }

  // Member Methods
  Future<void> addMember() async {
    try {
      final name = _getValidInput('Enter member name: ');
      final membershipId = _getValidInput('Enter membership ID: ');
      _getValidDateInput('Enter membership start date (YYYY-MM-DD): ');

      final newMember = Member(name: name, memberId: membershipId, borrowedBooks: []);
      members.add(newMember);
      await dataPersistence.saveMember(newMember); // Save member via API
      print('Member added successfully.');
    } catch (e) {
      print('Error adding member: $e');
    }
  }

  Future<void> updateMember(String memberId) async {
    try {
      final member = members.firstWhere((m) => m.memberId == memberId,
          orElse: () => throw Exception('Member not found.'));
      stdout.write('Enter new name (leave empty to keep unchanged): ');
      final name = stdin.readLineSync();
      stdout.write('Enter new membership start date (leave empty to keep unchanged): ');
      final sinceInput = stdin.readLineSync();

      if (name != null && name.isNotEmpty) member.name = name;
      if (sinceInput != null && sinceInput.isNotEmpty) 
        member.borrowedBooks = DateTime.parse(sinceInput) as List<String>;

      await dataPersistence.updateMember(member.memberId, member); 
      print('Member updated.');
    } catch (e) {
      print('Error updating member: $e');
    }
  }

  Future<void> deleteMember(String memberId) async {
    try {
      members.removeWhere((m) => m.memberId == memberId);
      await dataPersistence.deleteMember(memberId); 
      print('Member deleted.');
    } catch (e) {
      print('Error deleting member: $e');
    }
  }

  // Helper methods to get valid inputs
  String _getValidInput(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        return input;
      }
      print('Invalid input. Please try again.');
    }
  }

  DateTime _getValidDateInput(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        try {
          return DateTime.parse(input);
        } catch (e) {
          print('Invalid date format. Please use YYYY-MM-DD.');
        }
      } else {
        print('Input cannot be empty. Please try again.');
      }
    }
  }

  int _getValidIntInput(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync();
      if (input != null && input.isNotEmpty) {
        try {
          final intInput = int.parse(input);
          if (intInput >= 1000 && intInput <= 9999) {
            return intInput;
          } else {
            print('Invalid input. Please enter a 4-digit number.');
          }
        } catch (e) {
          print('Invalid input. Please enter a valid number.');
        }
      } else {
        print('Input cannot be empty. Please try again.');
      }
    }
  }
 void returnBook(String isbn) {
    final book = books.firstWhere((b) => b.isbn == isbn, orElse: () => throw Exception('Book not found.'));
    
    print('Book returned successfully: ${book.title}');
  }

  
  void viewAuthors() {
    if (authors.isEmpty) {
      print('No authors available.');
    } else {
      for (var author in authors) {
        print(author);
      }
    }
  }

  
  void viewMembers() {
    if (members.isEmpty) {
      print('No members available.');
    } else {
      for (var member in members) {
        print(member);
      }
    }
  }
}
