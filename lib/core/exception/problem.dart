import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Problem {
  int status;
  String title;
  String detail;
  String userMessage;
  DateTime timestamp;
  List<dynamic>? objects;
  Problem({
    required this.status,
    required this.title,
    required this.detail,
    required this.userMessage,
    required this.timestamp,
    this.objects,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'title': title,
      'detail': detail,
      'userMessage': userMessage,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'objects': objects,
    };
  }

  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
      status: map['status'] as int,
      title: map['title'] as String,
      detail: map['detail'] as String,
      userMessage: map['userMessage'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      objects: map['objects'] != null ? List<dynamic>.from((map['objects'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Problem.fromJson(String source) => Problem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Problem(status: $status, title: $title, detail: $detail, userMessage: $userMessage, timestamp: $timestamp, objects: $objects)';
  }
}
