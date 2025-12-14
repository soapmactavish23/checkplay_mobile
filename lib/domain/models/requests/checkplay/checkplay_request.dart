// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:checkplay_mobile/domain/models/requests/category/category_request.dart';

class CheckplayRequest {
  String? id;
  CategoryRequest category;
  String name;
  String? description;

  CheckplayRequest({
    this.id,
    required this.category,
    required this.name,
    this.description,
  });

  factory CheckplayRequest.empty() {
    return CheckplayRequest(
      category: CategoryRequest.empty(),
      name: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'name': name,
      'description': description,
    };
  }

  factory CheckplayRequest.fromMap(Map<String, dynamic> map) {
    return CheckplayRequest(
      id: map['id'] != null ? map['id'] as String : null,
      category:
          CategoryRequest.fromMap(map['category'] as Map<String, dynamic>),
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckplayRequest.fromJson(String source) =>
      CheckplayRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CheckplayRequest(id: $id, category: $category, name: $name, description: $description)';
  }
}
