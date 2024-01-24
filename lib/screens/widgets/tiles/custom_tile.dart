import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/screens/widgets/details/rounder_detail.dart';
import 'package:sizer/sizer.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool noEllipsis;
  final IconData icon;
  final Color color;
  final bool showEdit;
  final VoidCallback? editAccion;
  final bool useAppFont;
  final String assetImage;

  const CustomTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.noEllipsis = false,
    required this.icon,
    required this.color,
    this.showEdit = false,
    this.editAccion,
    this.useAppFont = false,
    this.assetImage = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color titleColor = theme.colorScheme.onSurface;

    return ListTile(
        onTap: editAccion,
        tileColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.26),
        splashColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: assetImage != ""
            ? SizedBox(
                height: 11.w,
                width: 11.w,
                child: Image.asset(assetImage),
              )
            : RounderDetail(
                color: color,
                icon: icon,
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: useAppFont ? 15.sp : 12.sp,
              height: 1,
              fontFamily: useAppFont ? "Vibur" : null,
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
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            overflow: noEllipsis ? null : TextOverflow.ellipsis,
          ),
        ),
        trailing: Visibility(visible: showEdit, child: Icon(Icons.chevron_right_outlined, color: Theme.of(context).colorScheme.primary)));
  }
}
