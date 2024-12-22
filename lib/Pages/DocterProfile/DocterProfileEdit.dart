import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/ProfileController.dart';
import '../../Models/Doctor.dart';
import '../../Models/LocalProfile.dart';
import '../../Widgets/NotificationWidget.dart';

class DoctorProfileEdit extends StatelessWidget {
  final LocalProfile doctor;
  const DoctorProfileEdit({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: doctor.name);
    TextEditingController experienceController =
        TextEditingController(text: doctor.experience.toString());
    TextEditingController ratingController =
        TextEditingController(text: doctor.rating.toString());
    TextEditingController specialistController =
        TextEditingController(text: doctor.specialization);
    TextEditingController patientNoController =
        TextEditingController(text: doctor.patientNo.toString());
    TextEditingController priceController =
        TextEditingController(text: doctor.price.toString());
    TextEditingController clinicAddressController =
        TextEditingController(text: doctor.clinicAddress);
    TextEditingController aboutUsController =
        TextEditingController(text: doctor.aboutUs);
    ProfileController doctorProfileController =
        Get.put(ProfileController());
         Rx<XFile?> image = Rx<XFile?>(null);
    return Scaffold(
      floatingActionButton: Obx(
        () => doctorProfileController.isLoading.value
            ? FloatingActionButton(
                onPressed: () {},
                child: const CircularProgressIndicator(),
              )
            : FloatingActionButton.extended(
                onPressed: () async{
                    if (image.value == null) {
                    errorMessage("Please select an image");
                    return;
                  }
                  String? imageUrl = await doctorProfileController.uploadImageToFirebaseStorage(image.value!);
                  var newDoctor = DoctorModel(
                    profileImage: imageUrl,
                    name: nameController.text,
                    experience: int.parse(experienceController.text),
                    rating: double.parse(ratingController.text),
                    specialization: specialistController.text,
                    patientNo: int.parse(patientNoController.text),
                    price: priceController.text,
                    clinicAddress: clinicAddressController.text,
                    aboutUs: aboutUsController.text,
                    id: doctor.id,
                    userName: doctor.userName,
                    hashPassword: doctor.hashPassword,
                    qualification: doctor.qualification,
                    contactNumber: doctor.contactNumber,
                    email: doctor.email,
                    timings: doctor.timings,
                    role: doctor.role,

                  );
                  doctorProfileController.updateDoctorProfile(newDoctor);
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
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: experienceController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurple,
                            ),
                            hintText: "Experiance",
                            border: UnderlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: ratingController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurple,
                            ),
                            hintText: "Rating",
                            border: UnderlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: specialistController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      hintText: "Specialist",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: patientNoController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      hintText: "Patient no",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      hintText: "Price",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: clinicAddressController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      hintText: "Clienic Address",
                      border: UnderlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: aboutUsController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "About us",
                      border: UnderlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
