// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:checkplay_mobile/domain/models/responses/category/category_response.dart';

class CheckplayResponse {
  String id;
  CategoryResponse category;
  String name;
  String description;
  String status;
  String image;
  DateTime dtCreated;
  DateTime? dtInit;
  DateTime? dtFinish;
  
  CheckplayResponse({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.status,
    required this.image,
    required this.dtCreated,
    this.dtInit,
    this.dtFinish,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'name': name,
      'description': description,
      'status': status,
      'image': image,
      'dtCreated': dtCreated.millisecondsSinceEpoch,
      'dtInit': dtInit?.millisecondsSinceEpoch,
      'dtFinish': dtFinish?.millisecondsSinceEpoch,
    };
  }

  factory CheckplayResponse.fromMap(Map<String, dynamic> map) {
    return CheckplayResponse(
      id: map['id'] as String,
      category: CategoryResponse.fromMap(map['category'] as Map<String,dynamic>),
      name: map['name'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      image: map['image'] as String,
      dtCreated: DateTime.parse(map['dtCreated']),
      dtInit: map['dtInit'] != null ? DateTime.parse(map['dtInit']) : null,
      dtFinish: map['dtFinish'] != null ? DateTime.parse(map['dtFinish']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckplayResponse.fromJson(String source) => CheckplayResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CheckplayResponse(id: $id, category: $category, name: $name, description: $description, status: $status, image: $image, dtCreated: $dtCreated, dtInit: $dtInit, dtFinish: $dtFinish)';
  }
}
