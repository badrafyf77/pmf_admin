import 'package:flutter/material.dart';

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
