
// import 'dart:convert';

class Member {
  static final Set<String> _usedMemberIds={}; 

  String name;
  String memberId;
  List<String> borrowedBooks;

  Member({
    required this.name,
    required String memberId,
    required this.borrowedBooks,
  }) : this.memberId = _addMemberId(memberId); 

  static String _addMemberId(String memberId) {
    if (_usedMemberIds.contains(memberId)) {
      throw ArgumentError('Member ID must be unique. The provided member ID is already used.');
    }
    _usedMemberIds.add(memberId);
    return memberId;
  }

  
  static void removeMemberId(String memberId) {
    _usedMemberIds.remove(memberId);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'memberId': memberId,
        'borrowedBooks': borrowedBooks,
      };

  
    static Member fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      memberId: json['memberId'],
      borrowedBooks: List<String>.from(json['borrowedBooks']),
    ); 

  }
  
  @override
  String toString() {
    return 'Name: $name, ID: $memberId, Borrowed Books: ${borrowedBooks.join(', ')}';
  }
}




