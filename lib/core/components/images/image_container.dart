import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:checkplay_mobile/core/components/images/button_send_image.dart';
import 'package:checkplay_mobile/core/components/images/image_custom.dart';

class ImageContainer extends StatelessWidget {
  final dynamic image;
  final Function(XFile image) saveImage;
  const ImageContainer({
    super.key,
    required this.image,
    required this.saveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: ImageCustom.getImageWidget(image),
              )
            : Container(
                color: Colors.grey,
                height: 400,
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
        ButtonSendImage(
          saveImage: (image) {
            saveImage(image);
          },
        )
      ],
    );
  }
}
