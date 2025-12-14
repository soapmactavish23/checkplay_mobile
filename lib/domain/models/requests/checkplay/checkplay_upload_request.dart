// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class CheckplayUploadRequest {
  String id;
  File file;

  CheckplayUploadRequest({
    required this.id,
    required this.file,
  });

  Future<FormData> toMap() async {
    return FormData.fromMap({
      'id': id,
      "file": await MultipartFile.fromFile(file.path),
    });
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CheckplayUploadRequest(id: $id, file: $file)';
}
