// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class ImageFileCustom extends StatelessWidget {
  final dynamic file;

  const ImageFileCustom({
    Key? key,
    required this.file,
  }) : super(key: key);

  Widget getImage() {
    if (file is String) {
      return Image.network(file);
    } else if (file is File) {
      return Image.file(file);
    } else {
      return Container(
        decoration: const BoxDecoration(color: Colors.grey),
        child: const Center(
          child: Icon(Icons.videocam_off, size: 50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: getImage(),
    );
  }
}
