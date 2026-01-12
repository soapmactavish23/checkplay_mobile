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
    bool showGallery = true,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
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
              padding: padding,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: showGallery
                    ? GalleryImageView(
                        listImage: [provider],
                        boxFit: BoxFit.contain,
                      )
                    : ImageCustom.getImageWidget(
                        file,
                        showGallery: false,
                        boxFit: BoxFit.contain,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget getImageWidget(
    dynamic file, {
    BoxFit boxFit = BoxFit.cover,
    bool showGallery = true,
    double width = 200,
    double height = 200,
  }) {
    ImageProvider imageProvider;

    if (file is String && file.isNotEmpty) {
      if (file.startsWith("http")) {
        imageProvider = NetworkImage(file);
      } else if (file.startsWith('images/')) {
        imageProvider = AssetImage(file);
      } else {
        imageProvider = MemoryImage(base64Decode(file));
      }
    } else if (file is File) {
      imageProvider = FileImage(file);
    } else if (file is XFile) {
      imageProvider = FileImage(File(file.path));
    } else {
      imageProvider = const AssetImage(ImageConstants.not_found);
    }

    if (!showGallery) {
      return Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: boxFit,
      );
    }

    return GalleryImageView(
      listImage: [imageProvider],
      width: width,
      height: height,
      boxFit: boxFit,
      imageDecoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
    );
  }
}
