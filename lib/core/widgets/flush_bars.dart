
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showErrorMessage(BuildContext bc, String error, {int duration = 3}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Flushbar(
      title: "Error",
      backgroundColor: Colors.red,
      message: error,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: BorderRadius.circular(20),
      duration: Duration(seconds: duration),
    ).show(bc);
  });
}

showMessage(BuildContext bc, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Flushbar(
      title: "Success",
      backgroundColor: Colors.green,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: BorderRadius.circular(20),
      duration: const Duration(seconds: 3),
    ).show(bc);
  });
}

showBlueMessage(BuildContext bc, String message) {
  Flushbar(
    title: "Success",
    backgroundColor: Colors.red,
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    borderRadius: BorderRadius.circular(20),
    duration: const Duration(seconds: 3),
  ).show(bc);
}
