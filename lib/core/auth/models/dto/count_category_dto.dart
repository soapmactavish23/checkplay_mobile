// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:checkplay_mobile/core/auth/models/dto/count_product_dto.dart';

class CountCategoryDto {
  int id;
  String description;
  List<CountProductDto> products;
  
  CountCategoryDto({
    required this.id,
    required this.description,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory CountCategoryDto.fromMap(Map<String, dynamic> map) {
    return CountCategoryDto(
      id: map['id'] as int,
      description: map['description'] as String,
      products: List<CountProductDto>.from((map['products'] as List<int>).map<CountProductDto>((x) => CountProductDto.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountCategoryDto.fromJson(String source) => CountCategoryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CountCategoryDto(id: $id, description: $description, products: $products)';
}
