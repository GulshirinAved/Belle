import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../widgets.dart';

class ChosenImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String path;
  final String? imagePath;
  final VoidCallback onDeleteTap;

  const ChosenImageWidget({
    super.key,
    required this.height,
    required this.width,
    required this.path,
    required this.onDeleteTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.radiusSmall)),
              child: Builder(builder: (context) {
                if (imagePath != null) {
                  return CachingImage(
                    imagePath,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  );
                }
                return Image.file(
                  File(path),
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                );
              }),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                onPressed: onDeleteTap,
                style: IconButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
