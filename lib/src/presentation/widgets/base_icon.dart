import 'package:flutter/material.dart';

class BaseIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const BaseIcon({
    super.key,
    required this.icon,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 24,
      color: color,
    );
  }
}
