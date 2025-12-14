// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class CategoryUploadRequest {
  String? id;
  File? image;
  CategoryUploadRequest({
    this.id,
    this.image,
  });

  Future<FormData> toMap() async {
    return FormData.fromMap({
      'id': id,
      "image": await MultipartFile.fromFile(image!.path),
    });
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CategoryUpload(id: $id, image: $image)';
}
