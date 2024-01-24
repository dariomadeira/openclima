import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:sizer/sizer.dart';

class SquareBtnWidget extends StatelessWidget {
  final String label;
  final VoidCallback accion;
  final Color? color;
  final double? width;
  final bool isDark;
  final IconData? icon;

  const SquareBtnWidget({
    Key? key,
    required this.label,
    required this.accion,
    this.color,
    this.width,
    this.isDark = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorHelpers = ColorsHelper();
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color textColor = colorHelpers.darken(color: theme.colorScheme.primaryContainer);
    final useColor = color ?? primaryColor;
    final bool isDarkThemeOn = theme.brightness == Brightness.dark;
    final calculatedWidth = width ?? 26.w;

    Color calculateTextColorforBtn() {
      if (isDarkThemeOn) {
        return textColor;
      } else {
        return Colors.white;
      }
    }

    return SizedBox(
      width: calculatedWidth,
      child: FilledButton(
        onPressed: accion,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isDark ? useColor : colorHelpers.calculateBGColor(color: useColor, context: context)),
          foregroundColor: MaterialStateProperty.all(isDark ? calculateTextColorforBtn() : colorHelpers.calculateTextColor(color: useColor, context: context)),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return isDark ? Colors.white.withOpacity(0.16) : colorHelpers.calculateRippleColor(color: useColor, context: context);
            }
            return null;
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding / 1.4),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: icon != null ? kDefaultPadding / 2 : kDefaultPadding / 1.2),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (icon != null) Icon(icon, size: 21.sp),
            SizedBox(height: icon != null ? 0.3.h : 0),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                )),
          ]),
        ),
      ),
    );
  }
}
