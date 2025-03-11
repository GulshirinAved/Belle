import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../choose_image_widget.dart';

class ChooseAndChosenFileWidget extends StatelessWidget {
  final XFile? image;
  final String? imagePath;
  final double height;
  final double width;
  final VoidCallback onDeleteTap;
  final VoidCallback onPickTap;
  final String? Function(Object?)? validator;
  final Widget? emptyWidget;

  const ChooseAndChosenFileWidget({
    super.key,
    this.image,
    required this.height,
    required this.width,
    required this.onDeleteTap,
    required this.onPickTap,
    this.validator,
    this.imagePath,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath == null && image == null) {
      if (emptyWidget != null) {
        return GestureDetector(onTap: onPickTap, child: emptyWidget!);
      }
      return ChooseFileWidget(
        onTap: onPickTap,
        validator: (_) {
          return;
        },
      );
    }

    return ChosenImageWidget(
      height: height,
      width: width,
      path: image?.path ?? '',
      imagePath: imagePath,
      onDeleteTap: onDeleteTap,
    );
  }
}
