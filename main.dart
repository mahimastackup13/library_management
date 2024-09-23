
import 'library.dart';
import 'dart:io';
// import 'dart:convert';
// import 'datapersistence.dart';
import 'library_api.dart';

void main() async {
  final libraryManager = LibraryManager();
  // await libraryManager.loadData();
  final dataPersistence=DataPersistence(libraryManager);
  await dataPersistence.loadData();

  while (true) {
    print('Library Management System');
    print('1. Add Book');
    print('2. View Books');
    print('3. Update Book');
    print('4. Delete Book');
    print('5. Search Books');
    print('6. Lend Book');
    print('7. Return Book');
    print('8. Add Author');
    print('9. View Authors');
    print('10. Update Author');
    print('11. Delete Author');
    print('12. Add Member');
    print('13. View Members');
    print('14. Update Member');
    print('15. Delete Member');
    print('16. Save');
    print('17. Exit');

    stdout.write('Choose an option: ');
    final option = stdin.readLineSync()!;

    switch (option) {
      case '1':
        await libraryManager.addBook();
        break;
      case '2':
        libraryManager.viewBooks();
        break;
      case '3':
        stdout.write('Enter ISBN of the book to update: ');
        final isbn = stdin.readLineSync()!;
        await libraryManager.updateBook(isbn);
        break;
      case '4':
        stdout.write('Enter ISBN of the book to delete: ');
        final isbn = stdin.readLineSync()!;
        await libraryManager.deleteBook(isbn);
        break;
      case '5':
        stdout.write('Enter search query:title/author/genre :-');
        final query = stdin.readLineSync()!;
        libraryManager.searchBooks(query);
        break;

      case '6':
        stdout.write('Enter ISBN of the book to lend: ');
        final isbn = stdin.readLineSync()!;
        stdout.write('Enter member ID: ');
        final memberId = stdin.readLineSync()!;
        await libraryManager.lendBook(isbn, memberId);
        break;
      case '7':
        stdout.write('Enter ISBN of the book to return: ');
        final isbn = stdin.readLineSync()!;
        await libraryManager.returnBook(isbn);
        break;
      case '8':
        await libraryManager.addAuthor();
        break;
      case '9':
        libraryManager.viewAuthors();
        break;
      case '10':
        stdout.write('Enter name of the author to update: ');
        final name = stdin.readLineSync()!;
        await libraryManager.updateAuthor(name);
        break;
      case '11':
        stdout.write('Enter name of the author to delete: ');
        final name = stdin.readLineSync()!;
        await libraryManager.deleteAuthor(name);
        break;
      case '12':
        await libraryManager.addMember();
        break;
      case '13':
        libraryManager.viewMembers();
        break;
      case '14':
        stdout.write('Enter member ID to update: ');
        final memberId = stdin.readLineSync()!;
        await libraryManager.updateMember(memberId);
        break;
      case '15':
        stdout.write('Enter member ID to delete: ');
        final memberId = stdin.readLineSync()!;
        await libraryManager.deleteMember(memberId);
        break;
      case '16':
        print('Saving data...');
        await dataPersistence.saveData();
        print('Data saved successfully.');
        break;
      case '17':
        print('Exiting...');
        return;
      default:
        print('Invalid option. Try again.');
    }
  }
  
}

