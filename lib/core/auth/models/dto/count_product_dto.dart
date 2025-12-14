import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CountProductDto {
  int total;
  String description;
  String color;
  CountProductDto({
    required this.total,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'description': description,
      'color': color,
    };
  }

  factory CountProductDto.fromMap(Map<String, dynamic> map) {
    return CountProductDto(
      total: map['total'] as int,
      description: map['description'] as String,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountProductDto.fromJson(String source) =>
      CountProductDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CountProductDto(total: $total, description: $description, color: $color)';
}
