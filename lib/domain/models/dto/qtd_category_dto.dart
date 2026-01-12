import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QtdCategoryDto {
  String name;
  String value;
  int total;
  QtdCategoryDto({
    required this.name,
    required this.value,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'total': total,
    };
  }

  factory QtdCategoryDto.fromMap(Map<String, dynamic> map) {
    return QtdCategoryDto(
      name: map['name'] as String,
      value: map['value'] as String,
      total: map['total'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QtdCategoryDto.fromJson(String source) =>
      QtdCategoryDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QtdCategoryDto(name: $name, value: $value, total: $total)';
}
