import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'base_icon_button.dart';

class BaseAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? actions;
  final bool showLeading;
  final Widget? leading;
  const BaseAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLeading = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeading
          ? (leading ??
              BaseIconButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.arrow_back_ios_new_rounded,
              ))
          : null,
      leadingWidth: 40,
      backgroundColor: kTheme.colorScheme.primary,
      elevation: 0,
      centerTitle: false,
      title: DefaultTextStyle(
        style: kTheme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: kTheme.colorScheme.onPrimary,
        ),
        child: FittedBox(
          child: title,
        ),
      ),
      actions: actions,
      actionsIconTheme: kTheme.iconTheme.copyWith(
        color: kTheme.colorScheme.onPrimary,
      ),
    );
  }
}
