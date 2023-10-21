import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';

class PartnerDashboardPage extends StatefulWidget {
  const PartnerDashboardPage({super.key});

  @override
  State<PartnerDashboardPage> createState() => _PartnerDashboardPageState();
}

class _PartnerDashboardPageState extends State<PartnerDashboardPage> {
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
      child: const SingleChildScrollView(
        child: Column(
          children: [
            ProgressTaskView(),
            kGapH12,
            DashboardTaskReminderView(),
            kGapH12,
            TaskAlmostDueView(),
          ],
        ),
      ),
    );
  }
}
