
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openclima/config/helpers/image_helper.dart';
import 'package:openclima/screens/widgets/commons/preload_widget.dart';

class BackgroundApp extends StatelessWidget {

  final String? svgAsset;
  final bool? useLoader;

  const BackgroundApp({
    super.key, 
    @required this.svgAsset,
    this.useLoader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: useLoader! 
        ? PreloadWidget(
            loadingFutures: [
              loadSvg(svgAsset!),
            ],
            child: _CreateBackground(
              svgAsset: svgAsset,
            ),
          )
        : _CreateBackground(
          svgAsset: svgAsset,
        ),
    );
  }
}

class _CreateBackground extends StatelessWidget {

  final String? svgAsset;

  const _CreateBackground({
    @required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final Color backgroundColor = themeData.scaffoldBackgroundColor;
    
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
        svgAsset!,
        fit: BoxFit.fill,
        allowDrawingOutsideViewBox: true,
        matchTextDirection: true,
      ),
    );
  }
}