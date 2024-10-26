import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomGridviewAnimationConfig extends StatelessWidget {
  const CustomGridviewAnimationConfig(
      {super.key,
      required this.index,
      required this.child,
      required this.columnCount});

  final int index;
  final int columnCount;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: columnCount,
      duration: const Duration(milliseconds: 150),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
