// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ButtonCameraGallery extends StatelessWidget {
  final void Function()? onPressedCamera;
  final dynamic Function(dynamic file)? onSelected;

  ButtonCameraGallery({
    Key? key,
    this.onPressedCamera,
    this.onSelected,
  }) : super(key: key);

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
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
          child: const Row(
            children: [
              Icon(Icons.image),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Galeria"),
              ),
            ],
          ),
        ),
        ElevatedButton(
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
          child: const Row(
            children: [
              Icon(Icons.camera_alt),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Câmera"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
