import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:sizer/sizer.dart';

void showSnackbar({
  required String message,
  required BuildContext context,
  required String type,
}) async {
  final ThemeData theme = Theme.of(context);
  final Color primaryColor = theme.colorScheme.primary;
  Color snackBarBackgroundColor = theme.snackBarTheme.backgroundColor ?? primaryColor;
  switch (type) {
    case "error":
      snackBarBackgroundColor = theme.colorScheme.error;
      break;
    case "success":
      snackBarBackgroundColor = kSnackSuccess;
      break;
  }
  await Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    duration: const Duration(seconds: kDefaultTime),
    margin: EdgeInsets.all(kDefaultPadding),
    borderRadius: BorderRadius.circular(kDefaultPadding / 1.4),
    backgroundColor: snackBarBackgroundColor,
  ).show(context);
}
