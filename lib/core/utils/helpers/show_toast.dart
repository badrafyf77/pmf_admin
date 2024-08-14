import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void myShowToastSuccess(BuildContext context, String text) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: const Duration(seconds: 5),
    alignment: Alignment.bottomCenter,
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
  );
}

void myShowToastError(BuildContext context, String text) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: const Duration(seconds: 5),
    alignment: Alignment.bottomCenter,
    type: ToastificationType.error,
    style: ToastificationStyle.fillColored,
  );
}

void myShowToastInfo(BuildContext context, String text) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: const Duration(seconds: 5),
    alignment: Alignment.bottomCenter,
    type: ToastificationType.info,
    style: ToastificationStyle.minimal,
  );
}
