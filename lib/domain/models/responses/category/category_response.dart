import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryResponse {
  String id;
  String name;
  String image;
  CategoryResponse({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory CategoryResponse.fromMap(Map<String, dynamic> map) {
    return CategoryResponse(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromJson(String source) =>
      CategoryResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryResponse(id: $id, name: $name, image: $image)';
}
