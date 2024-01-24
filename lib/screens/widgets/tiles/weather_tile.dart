import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
// import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:sizer/sizer.dart';

class WeatherTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String value;
  final bool noEllipsis;
  final IconData? icon;
  final Color? color;
  final String assetImage;

  const WeatherTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.noEllipsis = false,
    this.icon,
    this.color,
    required this.assetImage,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final colorsHelper = ColorsHelper();
    ThemeData theme = Theme.of(context);
    // Color backgroundColor = colorsHelper.lighten(color: theme.colorScheme.surface);
    Color titleColor = theme.colorScheme.onSurface;

    return ListTile(
      tileColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.26),
      splashColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: SizedBox(
        height: 11.w,
        width: 11.w,
        child: Image.asset(assetImage),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            height: 1,
            fontWeight: FontWeight.w600,
            color: titleColor,
            overflow: noEllipsis ? null : TextOverflow.ellipsis,
          ),
        ),
      ),
      subtitle: Text(
        subtitle ?? '',
        style: TextStyle(
          height: 1.2,
          fontSize: 12.sp,
          overflow: noEllipsis ? null : TextOverflow.ellipsis,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    );
  }
}
