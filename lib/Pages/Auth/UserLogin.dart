import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/Auth/DoctorLogin.dart';
import 'package:myapp/Pages/Auth/UserSignup.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';
import 'package:myapp/Widgets/MySecondryButton.dart';

import '../../Controllers/AuthController.dart';
import 'ForgotPassword.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
     AuthController authController = Get.put(AuthController());
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 60),
                  const Text(
                    "User Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Login to our system to access all feature"),
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
                  const SizedBox(height: 8),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [InkWell(
                        onTap: () {
                          Get.to(const ForgotPassword(),transition: Transition.rightToLeft,);
                        },
                        child: Text("Forgot Password?"))],
                  ),
                  const SizedBox(height: 100),
                  Obx(
                  () => authController.isLoading.value
                      ? const LinearProgressIndicator()
                      : MyPrimaryButton(
                          icon: Icons.login,
                          onPressed: () {
                            authController.loginUserAsync(
                              email.text,
                              password.text,
                            );
                          },
                          text: "Login",
                        ),
                ),
                  
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
                          icon: Icons.create,
                          onPressed: () {
                            Get.to(const UserSignup(), transition: Transition.rightToLeft,);
                          },
                          text: "Sign Up",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MySecondaryButton(
                          icon: Icons.medical_information,
                          onPressed: () {
                            Get.to(const DoctorLogin(), transition: Transition.rightToLeft,);
                          },
                          text: "Doctor",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
