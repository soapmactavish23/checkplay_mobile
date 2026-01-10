// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:checkplay_mobile/core/components/utils/dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ButtonSendImage extends StatefulWidget {
  Function(XFile image) saveImage;
  final bool disabled;
  ButtonSendImage({
    super.key,
    required this.saveImage,
    this.disabled = false,
  });

  @override
  State<ButtonSendImage> createState() => _ButtonSendImageState();
}

class _ButtonSendImageState extends State<ButtonSendImage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> cropImage(XFile selectedImage) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          showCropGrid: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: 'Editar Imagem',
          aspectRatioLockEnabled: false,
          resetAspectRatioEnabled: true,
          aspectRatioPickerButtonHidden: false,
        ),
      ],
    );

    if (croppedFile != null) {
      widget.saveImage(XFile(croppedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: OutlinedButton(
        onPressed: widget.disabled
            ? null
            : () async {
                DialogCustom.dialogComponent(
                  context: context,
                  title: 'Selecione',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Câmera'),
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? selectedImage = await _picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (selectedImage != null) {
                            await cropImage(selectedImage);
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Galeria'),
                        onTap: () async {
                          Navigator.pop(context);
                          final XFile? selectedImage = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (selectedImage != null) {
                            await cropImage(selectedImage);
                          }
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.camera_alt),
              ),
              Text(
                'Enviar Foto',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
