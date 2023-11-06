import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:wedding_planner_management/src/presentation/page/profile/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileView(),
                kGapH12,
                _MyCategory(),
                kGapH12,
                _LogoutButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MyCategory extends GetView<ProfileController> {
  const _MyCategory();

  @override
  Widget build(BuildContext context) {
    final String title = controller.currentUser?.role.isPartner ?? false
        ? 'Danh mục dịch vụ của tôi'
        : 'Danh mục công việc của tôi';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          leading: Icon(
            Icons.category_rounded,
            color: kTheme.colorScheme.primary,
          ),
          title: Text(
            title,
            style: kTheme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        UserCategoryView(
          categoryId: controller.currentUser?.extraData['categoryId'],
          config: UserCategoryViewConfig(
            isShowCommission: controller.currentUser?.role.isPartner ?? false,
          ),
        ),
      ],
    );
  }
}

class _LogoutButton extends GetView<ProfileController> {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: controller.logout,
      icon: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      label: Text(
        'Đăng xuất',
        style: kTheme.textTheme.titleMedium!.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
