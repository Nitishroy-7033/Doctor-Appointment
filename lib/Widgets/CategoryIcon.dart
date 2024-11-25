import 'package:flutter/material.dart';

class Categoryicon extends StatelessWidget {
  final IconData icon;
  final String text;
  const Categoryicon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 10),
        Text(text),
      ],
    );
  }
}
