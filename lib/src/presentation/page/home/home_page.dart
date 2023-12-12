import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_planner_management/core/routers/router_constant.dart';

import 'home_controller.dart';
import 'widgets/bottom_navigation_tabbar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const BottomNavigationTabBar(),
        appBar: controller.currentTab.value.isHasAppbar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  title: Text(
                    controller.currentTab.value.title,
                  ),
                  // centerTitle: true,
                  actions: [
                    if (controller.currentTab.value.actions != null)
                      ...controller.currentTab.value.actions!,
                    IconButton.filledTonal(
                      onPressed: () {
                        Get.toNamed(RouterConstants.notifications);
                      },
                      icon: const Icon(
                        Icons.notifications,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.homeTab.tabs.map((e) => e.page).toList(),
        ),
        // floatingActionButton: const CartFloatingActionButton(),
      ),
    );
  }
}
