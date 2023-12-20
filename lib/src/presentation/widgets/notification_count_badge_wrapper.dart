import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_planner_management/src/presentation/global/app_controller.dart';

class NotificationCountBadgeWrapper extends GetView<AppController> {
  final Widget child;
  const NotificationCountBadgeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          child,
          if (controller.notificationCount.value > 0)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  controller.notificationCount.value > 99
                      ? '99+'
                      : controller.notificationCount.value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
        ],
      ),
    );
  }
}
