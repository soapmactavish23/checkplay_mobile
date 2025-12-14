import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PasswordDto {
  String code;
  String oldPassword;
  String confirmPassword;
  String newPassword;
  
  PasswordDto({
    required this.code,
    required this.oldPassword,
    required this.confirmPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'oldPassword': oldPassword,
      'confirmPassword': confirmPassword,
      'newPassword': newPassword,
    };
  }

  factory PasswordDto.fromMap(Map<String, dynamic> map) {
    return PasswordDto(
      code: map['code'] as String,
      oldPassword: map['oldPassword'] as String,
      confirmPassword: map['confirmPassword'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordDto.fromJson(String source) =>
      PasswordDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PasswordDto(code: $code, oldPassword: $oldPassword, confirmPassword: $confirmPassword, newPassword: $newPassword)';
  }
}
