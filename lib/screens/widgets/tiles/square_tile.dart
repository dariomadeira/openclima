import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:sizer/sizer.dart';

class SquareTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;
  final String value;


  const SquareTile({
    super.key, 
    required this.title, 
    required this.subtitle, 
    required this.assetImage,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 11.w,
                width: 11.w,
                child: Image.asset(assetImage),
              ),
              SizedBox(width: kDefaultPadding / 2),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
              value,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}