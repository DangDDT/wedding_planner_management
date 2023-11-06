import 'package:flutter/material.dart';
import 'package:task_management_module/core/task_management_module.dart';
import 'package:wedding_planner_management/core/core.dart';

class StaffDashboardPage extends StatefulWidget {
  const StaffDashboardPage({super.key});

  @override
  State<StaffDashboardPage> createState() => _StaffDashboardPageState();
}

class _StaffDashboardPageState extends State<StaffDashboardPage> {
  final ProgressTaskController _progressTaskController =
      ProgressTaskController();

  final DashboardTaskReminderController _dashboardTaskReminderController =
      DashboardTaskReminderController();

  final TaskAlmostDueController _taskAlmostDueController =
      TaskAlmostDueController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          _progressTaskController.loadTaskProgressData(),
          _dashboardTaskReminderController.loadTaskEventReminderModel(),
          _taskAlmostDueController.loadTaskProgressData(),
        ]);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            ProgressTaskView(
              controller: _progressTaskController,
            ),
            kGapH12,
            TaskAlmostDueView(
              controller: _taskAlmostDueController,
            ),
            kGapH12,
            DashboardTaskReminderView(
              controller: _dashboardTaskReminderController,
            ),
          ],
        ),
      ),
    );
  }
}
