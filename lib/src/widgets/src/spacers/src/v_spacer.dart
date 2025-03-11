import 'package:flutter/material.dart';

class VSpacer extends StatelessWidget {
  final bool isSliver;
  final double? height;
  const VSpacer(this.height, {super.key, this.isSliver = false});

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(height: height);
    if (isSliver) {
      return SliverToBoxAdapter(
        child: child,
      );
    }
    return child;
  }
}
