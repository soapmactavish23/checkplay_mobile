import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DashboardRequest {
  int month;
  int year;
  DashboardRequest({
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'year': year,
    };
  }

  factory DashboardRequest.fromMap(Map<String, dynamic> map) {
    return DashboardRequest(
      month: map['month'] as int,
      year: map['year'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardRequest.fromJson(String source) =>
      DashboardRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
