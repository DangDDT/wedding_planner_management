// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../home_controller.dart';

class BottomNavigationTabBar extends GetView<HomeController> {
  const BottomNavigationTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller.tabController,
      tabs: controller.homeTab.tabs
          .map(
            (e) => FittedBox(
              child: _TabBarItem(tab: e),
            ),
          )
          .toList(),
      onTap: controller.onPageChanged,
      indicatorColor: kTheme.colorScheme.primary,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: kTheme.colorScheme.primary,
      unselectedLabelColor: CupertinoColors.systemGrey,
      labelStyle: kTheme.textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: kTheme.textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _TabBarItem extends Tab {
  final HomeTabItem tab;
  _TabBarItem({required this.tab})
      : super(
          icon: Icon(tab.icon),
          height: 64.0,
          iconMargin: const EdgeInsets.only(bottom: 2.0),
          text: tab.name,
        );
}
