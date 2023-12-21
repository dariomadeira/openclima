import 'package:flutter/material.dart';
import 'package:openclima/screens/widgets/details/rounded_detail.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RoundedDetail(
        icon: Icons.location_on_outlined,
        color: Colors.indigo,
        size: 50,
      ),
      title: const Text("Location"),
      subtitle: const Text("sdasdasas"),
    );
  }
}
