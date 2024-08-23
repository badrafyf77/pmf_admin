import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/animated_container.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.buttonTitle,
      required this.onPressedButton,
      required this.onPressedRefresh});

  final String buttonTitle;
  final dynamic Function() onPressedButton;
  final dynamic Function() onPressedRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavigateButton(
                buttonTitle: buttonTitle,
                onPressed: onPressedButton,
              ),
              RefreshIcon(
                onPressed: onPressedRefresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
  });

  final String buttonTitle;
  final dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedContainer(
      child: CustomButton(
        onPressed: onPressed,
        title: buttonTitle,
        backgroundColor: AppColors.kPrimaryColor,
      ),
    );
  }
}

class RefreshIcon extends StatelessWidget {
  const RefreshIcon({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      tooltip: 'Refresh',
    );
  }
}