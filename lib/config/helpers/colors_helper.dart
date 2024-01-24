import 'dart:math';
import 'package:flutter/material.dart';

class ColorsHelper {
  Color calculateBGColor({required Color color, required BuildContext context, double opacity = 0.16}) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return color;
    } else {
      return color.withOpacity(opacity);
    }
  }

  Color calculateTextColor({
    required Color color,
    required BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return Colors.white;
    } else {
      return color;
    }
  }

  Color calculateRippleColor({required Color color, required BuildContext context, double opacity = 0.16}) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return Colors.white.withOpacity(opacity);
    } else {
      return color.withOpacity(opacity);
    }
  }

  Color calculateHintColor({
    required Color color,
    required context,
    double? opacity = 0.6,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return color;
    } else {
      return color.withOpacity(opacity!);
    }
  }

  Color calculateColorInicials({required Color color, required BuildContext context, double opacity = 0.8}) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return Colors.white.withOpacity(opacity);
    } else {
      return color;
    }
  }

  Color darken({
    double amount = 0.1,
    required Color color,
  }) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten({
    double amount = .1,
    required Color color,
  }) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  Color randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
