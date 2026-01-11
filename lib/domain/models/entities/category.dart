import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  String? id;
  String name;
  dynamic image;
  double value;
  Category({
    this.id,
    required this.name,
    required this.image,
    required this.value
  });

  factory Category.empty() {
    return Category(name: '', image: null, value: 0.0);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : '',
      image: map['image'] as dynamic,
      value: map['value'] as double
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
