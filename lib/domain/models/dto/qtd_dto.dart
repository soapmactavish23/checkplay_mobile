import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QtdDto {
  double value;
  int total;
  QtdDto({
    required this.value,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'total': total,
    };
  }

  factory QtdDto.fromMap(Map<String, dynamic> map) {
    return QtdDto(
      value: map['value'] as double,
      total: map['total'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QtdDto.fromJson(String source) =>
      QtdDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QtdDto(value: $value, total: $total)';
}
