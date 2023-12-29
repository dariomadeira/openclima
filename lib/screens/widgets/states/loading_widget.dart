import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openclima/config/helpers/image_helper.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatelessWidget {

  final String? loadingMessage;
  final bool noShowMessage;
  final bool simpleLoad;

  const LoadingWidget({
    Key? key,
    this.loadingMessage = "",
    this.noShowMessage = false, 
    this.simpleLoad = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final String defaultMessage = loadingMessage == "" ? "Cargando" : loadingMessage!;
    const String defaultAnimation = 'assets/animations/sun.json';
    final animation = simpleLoad ? defaultAnimation : defaultAnimation;
    final ThemeData theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return FutureBuilder<LottieComposition>(
      future: loadComposition(animation),
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                animation,
                width: simpleLoad ? size.width/2 : size.width / 4,
                height: simpleLoad ? size.width/2 : size.width / 4,
                fit: BoxFit.fill,
              ),
              Visibility(
                visible: !noShowMessage,
                child: Padding(
                  padding: EdgeInsets.only(top: size.width / 2.7),
                  child: Text(
                    simpleLoad ? defaultMessage : defaultMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
