import 'package:flutter/material.dart';

class MySecondaryButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const MySecondaryButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.deepPurple,
            ),
            const SizedBox(width: 10),
            Text(text,
                style: const TextStyle(fontSize: 18, color: Colors.deepPurple)),
          ],
        ),
      ),
    );
  }
}
