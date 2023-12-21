import 'package:flutter/material.dart';

class RoundedDetail extends StatelessWidget {

  final double size;
  final IconData icon;
  final Color color;

  const RoundedDetail({
    super.key,
    this.size = 100,
    required this.icon,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(size/2),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black26,
          //     offset: Offset(0, 4),
          //     blurRadius: 6,
          //   ),
          // ],
        ),
        child: Center(
          child: Icon(
            icon, 
            color: color, 
            size: size * 0.8
          ),
        ));
  }
}
