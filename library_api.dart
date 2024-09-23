
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';
import 'author.dart';
import 'member.dart';
import 'library.dart';

class DataPersistence {
  final LibraryManager libraryManager;
  final String baseUrl = 'https://crudcrud.com/api/335b67fe07234cf984c2abeda444b271';

  DataPersistence(this.libraryManager);

  Future<void> saveData() async {
    try {
      var booksJson = jsonEncode(libraryManager.books);
      var authorsJson = jsonEncode(libraryManager.authors);
      var membersJson = jsonEncode(libraryManager.members);

      // Save Books
      var booksResponse = await http.post(
        Uri.parse('$baseUrl/books'),
        headers: {'Content-Type': 'application/json'},
        body: booksJson,
      );
      if (booksResponse.statusCode != 201) {
        print('Failed to save books: ${booksResponse.body}');
      }

      // Save Authors
      var authorsResponse = await http.post(
        Uri.parse('$baseUrl/authors'),
        headers: {'Content-Type': 'application/json'},
        body: authorsJson,
      );
      if (authorsResponse.statusCode != 201) {
        print('Failed to save authors: ${authorsResponse.body}');
      }

      // Save Members
      var membersResponse = await http.post(
        Uri.parse('$baseUrl/members'),
        headers: {'Content-Type': 'application/json'},
        body: membersJson,
      );
      if (membersResponse.statusCode != 201) {
        print('Failed to save members: ${membersResponse.body}');
      }

      print('Data saved successfully.');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> loadData() async {
    try {
      // Load Books
      var booksResponse = await http.get(Uri.parse('$baseUrl/books'));
      if (booksResponse.statusCode == 200) {
        var bookList = jsonDecode(booksResponse.body) as List;
        libraryManager.books = bookList.map((book) => Book.fromJson(book)).toList();
        print('Books loaded successfully.');
      } else {
        print('Error loading books: ${booksResponse.body}');
      }

      // Load Authors
      var authorsResponse = await http.get(Uri.parse('$baseUrl/authors'));
      if (authorsResponse.statusCode == 200) {
        var authorList = jsonDecode(authorsResponse.body) as List;
        libraryManager.authors = authorList.map((author) => Author.fromJson(author)).toList();
        print('Authors loaded successfully.');
      } else {
        print('Error loading authors: ${authorsResponse.body}');
      }

      // Load Members
      var membersResponse = await http.get(Uri.parse('$baseUrl/members'));
      if (membersResponse.statusCode == 200) {
        var memberList = jsonDecode(membersResponse.body) as List;
        libraryManager.members = memberList.map((member) => Member.fromJson(member)).toList();
        print('Members loaded successfully.');
      } else {
        print('Error loading members: ${membersResponse.body}');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
   

  }
  }

