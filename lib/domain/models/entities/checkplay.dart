// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:checkplay_mobile/domain/enums/checkplay_status.dart';
import 'package:checkplay_mobile/domain/models/entities/category.dart';

class Checkplay {
  String? id;
  Category category;
  String name;
  String description;
  String status = CheckplayStatus.PENDING;
  dynamic image;
  DateTime? dtCreated;
  DateTime? dtInit;
  DateTime? dtFinish;
  Checkplay({
    this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.status,
    required this.image,
    this.dtCreated,
    this.dtInit,
    this.dtFinish,
  });

  factory Checkplay.empty() {
    return Checkplay(
      id: null,
      category: Category.empty(),
      name: '',
      description: '',
      status: CheckplayStatus.PENDING,
      image: null,
      dtCreated: null,
      dtFinish: null,
      dtInit: null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': category.id,
      'name': name,
      'description': description,
    };
  }

  factory Checkplay.fromMap(Map<String, dynamic> map) {
    return Checkplay(
      id: map['id'] != null ? map['id'] as String : null,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      name: map['name'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      image: map['image'] as dynamic,
      dtCreated:
          map['dtCreated'] != null ? DateTime.parse(map['dtCreated']) : null,
      dtInit: map['dtInit'] != null ? DateTime.parse(map['dtInit']) : null,
      dtFinish:
          map['dtFinish'] != null ? DateTime.parse(map['dtFinish']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Checkplay.fromJson(String source) =>
      Checkplay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Checkplay(id: $id, category: $category, name: $name, description: $description, status: $status, image: $image, dtCreated: $dtCreated, dtInit: $dtInit, dtFinish: $dtFinish)';
  }
}
