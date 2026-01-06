// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

class UploadDto {
  String id;
  File image;
  UploadDto({
    required this.id,
    required this.image,
  });

  Future<FormData> toMap() async {
    return FormData.fromMap({
      "id": id,
      "file": await MultipartFile.fromFile(
        image.path,
      ),
    });
  }

  @override
  String toString() => 'UploadDto(id: $id, image: $image)';
}
