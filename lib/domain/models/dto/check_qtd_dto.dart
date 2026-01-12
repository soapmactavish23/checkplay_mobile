import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CheckQtdDto {
  int id;
  String name;
  double value;
  String? image;
  String? categoryImage;
  String categoryName;
  CheckQtdDto({
    required this.id,
    required this.name,
    required this.value,
    this.image,
    this.categoryImage,
    required this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
      'image': image,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
    };
  }

  factory CheckQtdDto.fromMap(Map<String, dynamic> map) {
    return CheckQtdDto(
      id: map['id'] as int,
      name: map['name'] as String,
      value: map['value'] as double,
      image: map['image'] != null ? map['image'] as String : null,
      categoryImage:
          map['categoryImage'] != null ? map['categoryImage'] as String : null,
      categoryName: map['categoryName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckQtdDto.fromJson(String source) =>
      CheckQtdDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
