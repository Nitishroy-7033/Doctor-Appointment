import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/ProfileController.dart';
import '../../Models/Doctor.dart';
import '../../Models/LocalProfile.dart';
import '../../Models/User.dart';
import '../../Widgets/NotificationWidget.dart';

class UserProfileEdit extends StatelessWidget {
  final LocalProfile doctor;
  const UserProfileEdit({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: doctor.name);
    TextEditingController phoneController =
        TextEditingController(text: doctor.name);
    ProfileController doctorProfileController = Get.put(ProfileController());
    Rx<XFile?> image = Rx<XFile?>(null);
    return Scaffold(
      floatingActionButton: Obx(
        () => doctorProfileController.isLoading.value
            ? FloatingActionButton(
                onPressed: () {},
                child: const CircularProgressIndicator(),
              )
            : FloatingActionButton.extended(
                onPressed: () async {
                  if (image.value == null) {
                    errorMessage("Please select an image");
                    return;
                  }
                  String? imageUrl = await doctorProfileController.uploadImageToFirebaseStorage(image.value!);
                  var newDoctor = UserModel(
                    phoneNumber: phoneController.text,
                    name: nameController.text,
                    id: doctor.id,
                    userName: doctor.userName,
                    hashPassword: doctor.hashPassword,
                    email: doctor.email,
                    profileImage: imageUrl,
                    role: doctor.role,
                  );
                  doctorProfileController.updateUserProfile(newDoctor);
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              ),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => image.value == null
                          ? InkWell(
                              onTap: () async {
                                image.value = await doctorProfileController.pickupImage();
                              },
                            child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.deepPurple,
                                ),
                              ),
                          )
                          : 
                          Container(
                            padding: const EdgeInsets.all(10),
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Image.file(
                              File(image.value!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Doctor name",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
