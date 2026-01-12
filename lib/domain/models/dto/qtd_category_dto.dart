import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QtdCategoryDto {
  String name;
  double value;
  int total;
  dynamic image;
  QtdCategoryDto({
    required this.name,
    required this.value,
    required this.total,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'total': total,
      'image': image
    };
  }

  factory QtdCategoryDto.fromMap(Map<String, dynamic> map) {
    return QtdCategoryDto(
        name: map['name'] as String,
        value: map['value'] as double,
        total: map['total'] as int,
        image: map['image']);
  }

  String toJson() => json.encode(toMap());

  factory QtdCategoryDto.fromJson(String source) =>
      QtdCategoryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QtdCategoryDto(name: $name, value: $value, total: $total)';
}
