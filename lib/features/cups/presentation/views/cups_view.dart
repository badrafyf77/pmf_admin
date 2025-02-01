import 'package:flutter/material.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/cups_list.dart';

class CupsView extends StatelessWidget {
  const CupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CupsList(),
    );
  }
}
