import 'package:flutter/material.dart';

class HSpacer extends StatelessWidget {
  final bool isSliver;
  final double? width;
  const HSpacer(this.width, {super.key, this.isSliver = false});

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(width: width);
    if (isSliver) {
      return SliverToBoxAdapter(
        child: child,
      );
    }
    return child;
  }
}
