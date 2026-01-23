import 'package:checkplay_mobile/core/components/images/image_custom.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CardMain extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final String title;
  final String? image;
  final Color colorStatus;
  final String? categoryImage;
  final Widget? subtitle;
  const CardMain({
    super.key,
    this.onTap,
    required this.title,
    required this.onLongPress,
    this.image,
    required this.colorStatus,
    this.subtitle,
    this.categoryImage = ImageConstants.logo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ImageCustom.cover(
                    showGallery: false,
                    image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                subtitle ?? Container(),
              ],
            ),
            Positioned(
              left: 10,
              top: 10,
              child: ImageCustom.getImageWidget(
                showGallery: false,
                categoryImage,
                width: 20,
                height: 20,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: colorStatus,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
