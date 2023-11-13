import 'package:flutter/material.dart';
import 'package:wedding_service_module/wedding_service_module.dart';

class RevenuePage extends StatelessWidget {
  const RevenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            RevenueStats(),
          ],
        ),
      ),
    );
  }
}
