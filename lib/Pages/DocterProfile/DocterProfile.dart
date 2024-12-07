import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/AuthController.dart';
import 'package:myapp/Pages/Documents/DocumentsPage.dart';

import '../../Controllers/ProfileController.dart';
import '../DoctorAppointmentHistory/DocterAppoinmentHisotry.dart';
import '../HelpAndSupport/HelpAndSupportPage.dart';
import 'DocterProfileEdit.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController doctorProfileController = Get.put(ProfileController());
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(
             transition: Transition.rightToLeft,
            DoctorProfileEdit(doctor: doctorProfileController.localProfile.value));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Profile"),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
          "Doctor Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  doctorProfileController.localProfile.value.profileImage != null && doctorProfileController.localProfile.value.profileImage!.isNotEmpty ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple.shade200,
                    ),
                    width: 150,

                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(doctorProfileController.localProfile.value.profileImage!, fit: BoxFit.cover,),
                    ),
                  ) : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple.shade200,
                    ),
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(()=>doctorProfileController.localProfile.value.name != null ? Text(
                doctorProfileController.localProfile.value.name!,
                style: const TextStyle(
                  fontSize: 26,
                ),
              ) : const SizedBox(),),
              Obx(()=>doctorProfileController.localProfile.value.email != null ? Text(
                doctorProfileController.localProfile.value.email!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ) : const SizedBox(),),


              Obx(()=>doctorProfileController.localProfile.value.specialization != null ? Text(
                doctorProfileController.localProfile.value.specialization!,
                style: const TextStyle(color: Colors.white),
              ) : const SizedBox()  ,),
              const SizedBox(height: 30),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Obx(()=>doctorProfileController.localProfile.value.experience != null ? Text(
                        doctorProfileController.localProfile.value.experience.toString(  ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : const SizedBox(),),
                      const Text(
                        "Experiance",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(()=>doctorProfileController.localProfile.value.patientNo != null ? Text(
                        doctorProfileController.localProfile.value.patientNo.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : const SizedBox(),),
                      const Text(
                        "Patients",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(()=>doctorProfileController.localProfile.value.rating != null ? Text(
                        doctorProfileController.localProfile.value.rating.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ) : const SizedBox(),),
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text('Settings'),
                ],
              ),
              ListTile(
                splashColor: Colors.deepPurple.shade300,
                onTap: () {
                  Get.to(DoctorAppointmentHistory(id: doctorProfileController.localProfile.value.id!), transition: Transition.rightToLeft,);
                },
                leading: const Icon(Icons.book),
                title: const Text("History"),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                splashColor: Colors.deepPurple.shade300,
                onTap: () {
                  Get.to(DocumentPage(userId: doctorProfileController.localProfile.value.id!));
                },
                leading: const Icon(Icons.document_scanner),
                title: const Text("Documents"),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                splashColor: Colors.deepPurple.shade300,
                onTap: () {
                  Get.to(HelpAndSupportPage());
                },
                leading: const Icon(Icons.info),
                title: const Text("Help/Supports"),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                splashColor: Colors.deepPurple.shade300,
                onTap: () {
                  authController.logout();
                },
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_right),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
