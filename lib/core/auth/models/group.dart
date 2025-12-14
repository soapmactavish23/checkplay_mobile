import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Group {
  String? id;
  String name;
  Group({
    this.id,
    required this.name,
  });

  factory Group.empty() {
    return Group(id: null, name: '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Group(id: $id, name: $name)';
}
