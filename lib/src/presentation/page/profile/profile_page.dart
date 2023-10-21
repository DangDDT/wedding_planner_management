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
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              UserProfileView(),
              Spacer(),
              _LogoutButton(),
            ],
          ),
        );
      },
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
