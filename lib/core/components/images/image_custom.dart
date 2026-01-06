import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';

abstract class ImageCustom {
  static ImageProvider<Object> getImageProvider(dynamic file) {
    if (file is String && file != "") {
      if (file.contains("https://")) {
        return NetworkImage(file);
      } else {
        return MemoryImage(base64Decode(file));
      }
    } else if (file is File) {
      return FileImage(file);
    } else if (file is XFile) {
      return FileImage(File(file.path));
    } else {
      return const AssetImage(ImageConstants.logo);
    }
  }

  static Widget cover(
    dynamic file, {
    double width = 260,
    double height = 180,
    double radius = 20,
  }) {
    final provider = getImageProvider(file);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: provider,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.25),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image(
                  image: provider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget? getImageWidget(dynamic file) {
    ImageProvider<Object> imageProvider;
    if (file is String && file != "") {
      if (file.contains("https://")) {
        imageProvider = Image.network(
          file,
          fit: BoxFit.cover,
        ).image;
      } else {
        imageProvider = Image.memory(
          base64Decode(file),
          fit: BoxFit.cover,
        ).image;
      }
    } else if (file is File || file is XFile) {
      file = File(file.path);
      imageProvider = Image.file(
        file,
        fit: BoxFit.cover,
      ).image;
    } else {
      imageProvider = Image.asset("images/not_found.png").image;
    }
    return GalleryImageView(
      listImage: [imageProvider],
      width: 200,
      height: 200,
      imageDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
    );
  }
}
