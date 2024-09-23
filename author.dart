
import 'dart:convert';

class Author {
  String id;
  String name;
  DateTime dob;
  List<String> booksWritten;

  Author({
    required this.name,
    required this.dob,
    required this.booksWritten,
  }) : id = generateId(name, dob);

  
  static String generateId(String name, DateTime dob) {
    final combined = '$name-${dob.toIso8601String()}';
    return base64Url.encode(utf8.encode(combined)); 
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dob': dob.toIso8601String(),
        'booksWritten': booksWritten,
      };

  static Author fromJson(Map<String, dynamic> json) => Author(
        name: json['name'],
        dob: DateTime.parse(json['dob']),
        booksWritten: List<String>.from(json['booksWritten']),
      );

  @override
  String toString() {
    return 'ID: $id, Name: $name, DOB: $dob, Books: ${booksWritten.join(', ')}';
  }
}

