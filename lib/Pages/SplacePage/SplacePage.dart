import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/SplaceController.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splacecontroller = Get.put(SplaceController());
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      body:  Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset("assets/logo.png")),
      ),
    );
  }
}
