import 'package:flutter/material.dart';

class ColorFilteredWrapper extends StatelessWidget {
  final Color? color;
  final Widget child;
  const ColorFilteredWrapper({super.key, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).colorScheme.primary,
        BlendMode.srcIn,
      ),
      child: child,
    );
  }
}
