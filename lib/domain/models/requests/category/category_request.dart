// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryRequest {
  String? id;
  String name;

  CategoryRequest(
    this.id,
    this.name,
  );

  factory CategoryRequest.empty() {
    return CategoryRequest(null, '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CategoryRequest.fromMap(Map<String, dynamic> map) {
    return CategoryRequest(
      map['id'] != null ? map['id'] as String : null,
      map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryRequest.fromJson(String source) =>
      CategoryRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryRequest(id: $id, name: $name)';
}
