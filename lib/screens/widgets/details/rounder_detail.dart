import 'package:flutter/material.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:sizer/sizer.dart';

class RounderDetail extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double? size;

  const RounderDetail({
    Key? key,
    required this.color,
    required this.icon,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final handleSize = size ?? 11.w;
    final colorsHelper = ColorsHelper();

    return Stack(
      children: [
        Container(
          height: handleSize,
          width: handleSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(handleSize / 2),
          ),
        ),
        Container(
          height: handleSize,
          width: handleSize,
          decoration: BoxDecoration(
            color: colorsHelper.calculateBGColor(color: color, context: context),
            borderRadius: BorderRadius.circular(handleSize / 2),
          ),
          child: Center(
            child: Icon(
              icon,
              color: colorsHelper.calculateColorInicials(color: color, context: context, opacity: 0.96),
              size: 5.6.w,
            ),
          ),
        ),
      ],
    );
  }
}
