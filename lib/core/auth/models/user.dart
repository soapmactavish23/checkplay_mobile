// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:checkplay_mobile/core/auth/models/group.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class User {
  String? id;
  String name;
  String email;
  String? password;
  bool status;
  Group group;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.status,
    required this.group,
  });

  factory User.empty() {
    return User(
      name: '',
      email: '',
      status: true,
      group: Group.empty(),
    );
  }

  Color getColorByStatus() {
    if (status) {
      return ColorsConstants.success;
    } else {
      return ColorsConstants.danger;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'status': status,
      'group': group.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      status: map['status'] as bool,
      group: Group.fromMap(map['group'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, status: $status, group: $group)';
  }

  String getTitleByStatus() {
    if (status) {
      return 'ATIVO';
    } else {
      return 'INATIVO';
    }
  }
}
