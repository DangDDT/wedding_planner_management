import 'package:flutter/material.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PersistentHeaderDelegate({
    required this.child,
    this.backgroundColor,
  });
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ??
            (overlapsContent
                ? null
                : Theme.of(context).scaffoldBackgroundColor),
        boxShadow: (overlapsContent &&
                Theme.of(context).brightness == Brightness.light)
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]
            : null,
      ),
      height: 50,
      child: child,
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
