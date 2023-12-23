import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart' show rootBundle;

Future loadSvg(String svgPath) async {
  var picture = SvgAssetLoader(svgPath);
  await svg.cache.putIfAbsent(picture.cacheKey(null), () => picture.loadBytes(null));
}

Future<Image> loadByNetwork(BuildContext context, String path) async {
  var picture = Image.network(path);
  await precacheImage(picture.image, context);
  return picture;
}

Future<Image> loadLocal(BuildContext context, String path) async {
  var picture = Image.asset(path);
  await precacheImage(picture.image, context);
  return picture;
}

Future<LottieComposition> loadComposition(String path) async {
  var assetData = await rootBundle.load(path);
  return await LottieComposition.fromByteData(assetData);
}