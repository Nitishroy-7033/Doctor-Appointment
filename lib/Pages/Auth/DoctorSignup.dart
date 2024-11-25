import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/Auth/DoctorLogin.dart';
import 'package:myapp/Pages/Auth/UserLogin.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';
import 'package:myapp/Widgets/MySecondryButton.dart';

import '../../Controllers/AuthController.dart';

class DoctorSignUp extends StatelessWidget {
  const DoctorSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController specialization = TextEditingController();
    TextEditingController price = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_circle_left_rounded))
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "New Doctor",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("Login to our system to access all feature"),
                const SizedBox(height: 20),
                 TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                      hintText: "Full Name",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 20),
                 TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon:
                          Icon(Icons.alternate_email, color: Colors.deepPurple),
                      hintText: "Email",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 20),
                 TextField(
                  controller: password,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        color: Colors.deepPurple,
                      ),
                      hintText: "Password",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 20),
                 TextField(
                  controller: specialization,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.cast_for_education,
                          color: Colors.deepPurple),
                      hintText: "Specilization field",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 20),
                 TextField(
                  controller: price,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon:
                          Icon(Icons.currency_rupee, color: Colors.deepPurple),
                      hintText: "Price/hr",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot Password?")],
                ),
                const SizedBox(height: 20),
               Obx(()=> authController.isLoading.value ? const LinearProgressIndicator() : MyPrimaryButton(
                  icon: Icons.save,
                  onPressed: () {
                    authController.createDoctorAccountAsync(name.text, email.text, password.text, specialization.text, price.text);
                  },
                  text: "New Doctor",
                ))  ,
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("or")],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MySecondaryButton(
                        icon: Icons.login,
                        onPressed: () {
                          Get.to(const DoctorLogin(), transition: Transition.rightToLeft,);
                        },
                        text: "Login Doctor",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MySecondaryButton(
                        icon: Icons.person,
                        onPressed: () {
                          Get.to(const UserLogin(), transition: Transition.rightToLeft,);
                        },
                        text: "User",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
