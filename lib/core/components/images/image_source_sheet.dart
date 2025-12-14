import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({Key? key, required this.onSelected}) : super(key: key);

  dynamic Function(dynamic file)? onSelected;

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        )
      ],
    );
    if (croppedFile != null) {
      onSelected!(File(croppedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () async {
              final XFile? file =
                  await picker.pickImage(source: ImageSource.camera);
              try {
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Text("Câmera"),
          ),
          TextButton(
            onPressed: () async {
              final XFile? file =
                  await picker.pickImage(source: ImageSource.gallery);
              try {
                // ignore: use_build_context_synchronously
                editImage(file!.path, context);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Text("Galeria"),
          ),
        ],
      ),
    );
  }
}
