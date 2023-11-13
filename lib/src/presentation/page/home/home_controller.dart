import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/presentation/page/dashboard/partner/partner_dashboard_page.dart';
import 'package:wedding_planner_management/src/presentation/page/profile/profile_page.dart';
import 'package:wedding_planner_management/src/presentation/page/revenue/revenue_page.dart';
import 'package:wedding_service_module/wedding_service_module.dart';

import '../dashboard/staff/staff_dashboard_page.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ///Final
  late final Role currentRole;
  late final HomeTab homeTab;

  ///Controllers
  late TabController tabController;

  ///States
  late final Rx<HomeTabItem> currentTab;
  late final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    currentRole = UserModuleManager.currentUser!.role;
    homeTab = currentRole == Role.staff ? StaffHomeTab() : PartnerHomeTab();
    currentTab = Rx(homeTab.tabs.first);
    tabController = TabController(
      length: homeTab.tabs.length,
      vsync: this,
      initialIndex: 0,
    );
    super.onInit();
  }

  void onPageChanged(int index) {
    tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
    );
    currentTab.value = homeTab.tabs[index];
    currentIndex.value = index;
  }
}

class HomeTab {
  final List<HomeTabItem> tabs;

  HomeTab({
    required this.tabs,
  });
}

class StaffHomeTab extends HomeTab {
  StaffHomeTab()
      : super(
          tabs: [
            HomeTabItem(
              name: 'Công việc',
              title: 'Công việc của tôi',
              icon: Icons.work,
              page: const StaffDashboardPage(),
            ),
            HomeTabItem(
              name: 'Thông tin',
              title: 'Thông tin cá nhân',
              icon: Icons.person,
              page: const ProfilePage(),
              actions: [
                const IconButton(
                  onPressed: UserModuleManager.toEditProfilePage,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ],
        );
}

class PartnerHomeTab extends HomeTab {
  PartnerHomeTab()
      : super(
          tabs: [
            HomeTabItem(
              name: 'Công việc',
              title: 'Công việc của tôi',
              icon: Icons.work,
              page: const PartnerDashboardPage(),
            ),
            HomeTabItem(
              name: 'Dịch vụ',
              icon: Icons.store,
              page: const WeddingServicesPage(),
              isHasAppbar: false,
            ),
            HomeTabItem(
              name: 'Lịch bận',
              icon: Icons.calendar_today,
              page: const ServiceCalendarPage(),
              isHasAppbar: false,
            ),
            HomeTabItem(
              name: 'Doanh thu',
              title: 'Thống kê doanh thu',
              icon: Icons.monetization_on,
              page: const RevenuePage(),
            ),
            HomeTabItem(
              name: 'Thông tin',
              icon: Icons.person,
              page: const ProfilePage(),
              actions: [
                const IconButton(
                  onPressed: UserModuleManager.toEditProfilePage,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ],
        );
}

class HomeTabItem {
  final String name;
  final String title;
  final IconData icon;
  final Widget page;
  final List<Widget>? actions;
  final bool isHasAppbar;

  HomeTabItem({
    required this.name,
    String? title,
    required this.icon,
    required this.page,
    this.actions,
    this.isHasAppbar = true,
  }) : title = title ?? name;
}
