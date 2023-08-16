import 'package:flutter/material.dart';

import 'base_icon.dart';

class BaseIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const BaseIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: BaseIcon(
        icon: icon,
      ),
    );
  }
}
