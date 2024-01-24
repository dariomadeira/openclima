import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class EmptyWidget extends StatelessWidget {
  final List<String> emptyMessage;
  final String svgAsset;
  final double? finalSpace;

  const EmptyWidget({
    super.key,
    required this.emptyMessage,
    required this.svgAsset,
    this.finalSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgAsset,
          width: 56.w,
        ),
        SizedBox(height: 2.h),
        ...emptyMessage.asMap().entries.map((entry) {
          final index = entry.key;
          final message = entry.value;
          return Text(
            message,
            style: TextStyle(
              color: index > 0 ? Theme.of(context).primaryColor : null,
              fontSize: index == 0 ? 14.sp : 11.sp,
              fontWeight: index == 0 ? FontWeight.w800 : FontWeight.w500,
            ),
          );
        }),
        SizedBox(height: finalSpace ?? 0.h),
      ],
    ));
  }
}
