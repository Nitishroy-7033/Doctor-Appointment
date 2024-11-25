import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/Auth/DoctorLogin.dart';
import 'package:myapp/Pages/Auth/UserSignup.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';
import 'package:myapp/Widgets/MySecondryButton.dart';

import '../../Controllers/AuthController.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
     AuthController authController = Get.put(AuthController());
    TextEditingController email = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade300,
          title: const Text("Forgot Password",style: TextStyle(color: Colors.white),),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
            
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Enter your email to reset your password"),
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
                 
                  const SizedBox(height: 100),
                  Obx(
                  () => authController.isLoading.value
                      ? const LinearProgressIndicator()
                      : MyPrimaryButton(
                          icon: Icons.login,
                          onPressed: () {
                            authController.forgotPassword(email.text);
                          },
                          text: "Login",
                        ),
                ),
                  
                  const SizedBox(height: 10),
               
                ],
              ),
            ),
          ),
        )));
  }
}
