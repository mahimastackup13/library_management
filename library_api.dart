
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';
import 'author.dart';
import 'member.dart';
import 'library.dart';

class DataPersistence {
  final LibraryManager libraryManager;
  final String baseUrl = 'https://crudcrud.com/api/02f5b00f816b4addb74011313095a48a';

  DataPersistence(this.libraryManager);

   Future<void> saveData() async {
  try {
    // .....................................Save books.................//

    
    for (var book in libraryManager.books) {
      var bookJson = jsonEncode(book);
      var bookResponse = await http.post(
        Uri.parse('$baseUrl/books'),
        headers: {'Content-Type': 'application/json'},
        body: bookJson,
      );
      if (bookResponse.statusCode != 201) {
        print('Failed to save book: ${bookResponse.body}');
      }
    }

    //.................................... Save authors...................//


    for (var author in libraryManager.authors) {
      var authorJson = jsonEncode(author);
      var authorResponse = await http.post(
        Uri.parse('$baseUrl/authors'),
        headers: {'Content-Type': 'application/json'},
        body: authorJson,
      );
      if (authorResponse.statusCode != 201) {
        print('Failed to save author: ${authorResponse.body}');
      }
    }

    // .......................................Save members.................//


    for (var member in libraryManager.members) {
      var memberJson = jsonEncode(member);
      var memberResponse = await http.post(
        Uri.parse('$baseUrl/members'),
        headers: {'Content-Type': 'application/json'},
        body: memberJson,
      );
      if (memberResponse.statusCode != 201) {
        print('Failed to save member: ${memberResponse.body}');
      }
    }

    print('Data saved successfully.');
  } catch (e) {
    print('Error saving data: $e');
  }
}

  Future<void> loadData() async {
    try {
      //............................... Load Books..................................//


      var booksResponse = await http.get(Uri.parse('$baseUrl/books'));
      if (booksResponse.statusCode == 200) {
        var bookList = jsonDecode(booksResponse.body) as List;
        libraryManager.books = bookList.map((book) => Book.fromJson(book)).toList();
        print('Books loaded successfully.');
      } else {
        print('Error loading books: ${booksResponse.body}');
      }

      // ............................Load Authors........................................//


      var authorsResponse = await http.get(Uri.parse('$baseUrl/authors'));
      if (authorsResponse.statusCode == 200) {
        var authorList = jsonDecode(authorsResponse.body) as List;
        libraryManager.authors = authorList.map((author) => Author.fromJson(author)).toList();
        print('Authors loaded successfully.');
      } else {
        print('Error loading authors: ${authorsResponse.body}');
      }

      // ..............................Load Members.....................................//


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

