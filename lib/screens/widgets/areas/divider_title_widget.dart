import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:sizer/sizer.dart';

class DividerTitleWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool useTopPadding;
  final CrossAxisAlignment alignmentText;

  const DividerTitleWidget({
    Key? key,
    required this.title,
    this.useTopPadding = false,
    this.subTitle = "",
    this.alignmentText = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Padding(
      padding: useTopPadding ? EdgeInsets.only(top: kDefaultPadding / 2) : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: alignmentText,
        children: [
          Padding(
            padding: EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: primaryColor,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: kDefaultPadding / 6),
          Visibility(
            visible: subTitle != "",
            child: Padding(
              padding: EdgeInsets.only(left: kDefaultPadding / 2),
              child: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
