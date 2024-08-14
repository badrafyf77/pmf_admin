import 'package:pmf_admin/core/utils/customs/custom_scaffold.dart';
import 'package:pmf_admin/core/utils/customs/drawer.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Row(
        children: [
          const AppDrawer(),
          Expanded(
            child: body,
          )
        ],
      ),
    );
  }
}
