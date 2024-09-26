import 'dart:convert';
import 'books.dart';
import 'author.dart';
import 'member.dart';
import 'package:http/http.dart' as http;

class DataPersistence {
  final String booksApiUrl = 'https://crudcrud.com/api/f0177a4c693441ac9edd6fa43a7de5e8/books';
  final String authorsApiUrl = 'https://crudcrud.com/api/f0177a4c693441ac9edd6fa43a7de5e8/authors'; 
  final String membersApiUrl = 'https://crudcrud.com/api/f0177a4c693441ac9edd6fa43a7de5e8/members'; 

  // ....................................book.............................//

  Future<void> saveBook(Book book) async {
    final response = await http.post(
      Uri.parse(booksApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(book.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save book: ${response.body}');
    }
  }

  Future<void> updateBook(String id, Book book) async {
    final response = await http.put(
      Uri.parse('$booksApiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(book.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update book: ${response.body}');
    }
  }

  Future<void> deleteBook(String id) async {
    final response = await http.delete(
      Uri.parse('$booksApiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete book: ${response.body}');
    }
  }

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(booksApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((bookJson) => Book.fromJson(bookJson)).toList();
    } else {
      throw Exception('Failed to load books: ${response.body}');
    }
  }

  // ....................................author.................................................//

  Future<void> saveAuthor(Author author) async {
    final response = await http.post(
      Uri.parse(authorsApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(author.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save author: ${response.body}');
    }
  }

  Future<void> updateAuthor(String id, Author author) async {
    final response = await http.put(
      Uri.parse('$authorsApiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(author.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update author: ${response.body}');
    }
  }

  Future<void> deleteAuthor(String id) async {
    final response = await http.delete(
      Uri.parse('$authorsApiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete author: ${response.body}');
    }
  }

  Future<List<Author>> getAuthors() async {
    final response = await http.get(Uri.parse(authorsApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((authorJson) => Author.fromJson(authorJson)).toList();
    } else {
      throw Exception('Failed to load authors: ${response.body}');
    }
  }

  // ........................................... member...............................//

  Future<void> saveMember(Member member) async {
    final response = await http.post(
      Uri.parse(membersApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save member: ${response.body}');
    }
  }

  Future<void> updateMember(String id, Member member) async {
    final response = await http.put(
      Uri.parse('$membersApiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update member: ${response.body}');
    }
  }

  Future<void> deleteMember(String id) async {
    final response = await http.delete(
      Uri.parse('$membersApiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete member: ${response.body}');
    }
  }

  Future<List<Member>> getMembers() async {
    final response = await http.get(Uri.parse(membersApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((memberJson) => Member.fromJson(memberJson)).toList();
    } else {
      throw Exception('Failed to load members: ${response.body}');
    }
  }
}
