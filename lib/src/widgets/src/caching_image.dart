import 'package:belle/src/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter_svg/svg.dart';

class CachingImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;

  const CachingImage(this.imageUrl,
      {super.key, this.fit, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.contain,
      imageUrl: imageUrl ?? '',
      width: width ?? double.infinity,
      height: height,
      color: color,

      placeholder: (_, __) {
        return Padding(
          padding: EdgeInsets.all(
              height == null  ? AppDimensions.paddingMedium : 0.0),
          child: SvgPicture.asset(
            AppAssets.appLogoSVG,
            fit: BoxFit.contain,
          ),
        );
      },
      errorWidget: (_, __, ___) {
        return Padding(
          padding: EdgeInsets.all(
              height == null ? AppDimensions.paddingMedium : 0.0),
          child: SvgPicture.asset(
            AppAssets.appLogoSVG,
            fit: BoxFit.contain,
          ),
        );
      },
      // progressIndicatorBuilder: (context, _, progress) {
      //   return const ColoredBox(
      //     color: Color(0xFFE9E9E9),
      //   );
      // },
    );
  }
}

class CachingSVGImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;

  const CachingSVGImage(this.imageUrl,
      {super.key, this.fit, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageUrl ?? '',
      placeholderBuilder: (context) {
        return SvgPicture.asset(
          AppAssets.appLogoSVG,
          fit: BoxFit.contain,
        );
      },
      errorBuilder: (_, __, ___) {
        return SvgPicture.asset(
          AppAssets.appLogoSVG,
          fit: BoxFit.contain,
        );
      },
      fit: fit ?? BoxFit.contain,
      width: width ?? double.infinity,
      height: height,
      color: color,
    );
  }
}
