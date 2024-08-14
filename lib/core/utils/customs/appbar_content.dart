import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppbarContent extends StatelessWidget {
  const CustomAppbarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: MoveWindow(
        child: const Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(),
      ],
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: AppColors.kPrimaryColor,
  mouseOver: AppColors.kPrimaryColor,
  mouseDown: AppColors.kPrimaryColor,
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.white,
);
