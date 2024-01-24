import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:openclima/config/helpers/image_helper.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {
  final List<String>? loadingMessage;
  final String? svgAsset;
  final double? finalSpace;
  final bool noShowMessage;
  final bool useAnimation;

  const LoadingWidget({
    super.key,
    this.loadingMessage,
    this.svgAsset,
    this.finalSpace,
    this.noShowMessage = false,
    this.useAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> handleloadingMessage = loadingMessage!.isEmpty ? [tr("general_loading")] : loadingMessage!;
    const String defaultAnimation = 'assets/animations/sun.json';

    return useAnimation
        ? FutureBuilder<LottieComposition>(
            future: loadComposition(defaultAnimation),
            builder: (context, snapshot) {
              var composition = snapshot.data;
              if (composition != null) {
                return LoadingDesing(useAnimation: useAnimation, defaultAnimation: defaultAnimation, svgAsset: svgAsset, handleloadingMessage: handleloadingMessage, noShowMessage: noShowMessage, finalSpace: finalSpace);
              } else {
                return Container();
              }
            })
        : LoadingDesing(useAnimation: useAnimation, defaultAnimation: defaultAnimation, svgAsset: svgAsset, handleloadingMessage: handleloadingMessage, noShowMessage: noShowMessage, finalSpace: finalSpace);
  }
}

class LoadingDesing extends StatelessWidget {
  const LoadingDesing({
    super.key,
    required this.useAnimation,
    required this.defaultAnimation,
    required this.svgAsset,
    required this.handleloadingMessage,
    required this.noShowMessage,
    required this.finalSpace,
  });

  final bool useAnimation;
  final String defaultAnimation;
  final String? svgAsset;
  final List<String> handleloadingMessage;
  final bool noShowMessage;
  final double? finalSpace;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        useAnimation
            ? Lottie.asset(
                defaultAnimation,
                width: 30.w,
                height: 30.w,
                fit: BoxFit.fill,
              )
            : SvgPicture.asset(
                svgAsset!,
                width: 42.w,
              ),
        SizedBox(height: 2.h),
        ...handleloadingMessage.asMap().entries.map((entry) {
          final index = entry.key;
          final message = entry.value;
          return Visibility(
            visible: !noShowMessage,
            child: Text(
              message,
              style: TextStyle(
                color: index > 0 ? Theme.of(context).primaryColor : null,
                fontSize: index == 0 ? 14.sp : 11.sp,
                fontWeight: index == 0 ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          );
        }),
        SizedBox(height: finalSpace ?? 0.h),
      ],
    ));
  }
}
