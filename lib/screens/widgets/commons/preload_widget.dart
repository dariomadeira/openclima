import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:openclima/screens/widgets/states/loading_widget.dart';

class PreloadWidget extends StatelessWidget {
  final List<Future<dynamic>>? loadingFutures;
  final Widget? child;
  final Color? backgroundColor;

  const PreloadWidget({
    super.key,
    required this.loadingFutures,
    required this.child,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(loadingFutures!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Center(
              child: FadeIn(
                child: const LoadingWidget()
              ),
            ),
          );
        }
        return child!;
      },
    );
  }
}
