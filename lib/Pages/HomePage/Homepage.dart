import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ProfileController.dart';
import 'package:myapp/Pages/AllDoctors/AllDoctorsPage.dart';
import 'package:myapp/Pages/DoctorDetails/DoctorDetails.dart';
import 'package:myapp/Pages/Notifications/NotificationPage.dart';
import 'package:myapp/Widgets/CategoryIcon.dart';
import 'package:myapp/Widgets/DoctorCard.dart';
import 'package:myapp/Widgets/DoctorTile.dart';

import '../../Controllers/DoctorController.dart';
import '../../Controllers/RoleController.dart';
import '../../Models/Doctor.dart';
import '../../Widgets/NotificationWidget.dart';
import '../DocterProfile/DocterProfile.dart';
import '../UserProfile/UserProfile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    RoleController roleController = Get.put(RoleController());
    DoctorController doctorController = Get.put(DoctorController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (roleController.role.value == "doctor") {
                          Get.to(
                            const DoctorProfile(),
                            transition: Transition.rightToLeft,
                          );
                        } else {
                          Get.to(
                            const UserProfile(),
                            transition: Transition.rightToLeft,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 50,
                            height: 50,
                            child: Obx(() => profileController
                                        .localProfile.value.profileImage !=
                                    null &&
                                profileController.localProfile.value.profileImage !=
                                    ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      profileController
                                          .localProfile.value.profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.deepPurple,
                                    size: 30,
                                  )),
                          ),
                          const SizedBox(width: 10),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome"),
                             Obx(()=> Text("${profileController.localProfile.value.name}"),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(
                            const NotificationPage(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        icon: const Icon(Icons.notifications))
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                      Get.to(const AllDoctorsPage(),transition: Transition.rightToLeft,);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        Text("Search Doctors"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 130,
                  child: Image.asset("assets/banner.png"),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                  Text("Category"),
                  Text("See All",style: TextStyle(
                    color: Colors.blue
                  ),),
                ]),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                         Get.to(const AllDoctorsPage(searchValue: "Heart"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Heart");
                        },
                        child: const Categoryicon(
                            icon: Icons.heart_broken, text: "Heart")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Kidney"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Kidney");
                        },
                        child: const Categoryicon(
                            icon: Icons.king_bed_rounded, text: "Kidney")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Bone"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Bone");
                        },
                        child: const Categoryicon(
                            icon: Icons.medical_services_rounded, text: "Bone")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Brain"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Brain");
                        },
                        child:  const Categoryicon(
                            icon: Icons.medical_services_rounded, text: "Brain")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Eye"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Eye");
                        },
                        child: const Categoryicon(
                            icon: Icons.remove_red_eye, text: "Eye")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Liver"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Liver");
                        },
                        child: const Categoryicon(
                            icon: Icons.boy_rounded, text: "Liver")),
                    InkWell(
                        onTap: () {
                          Get.to(const AllDoctorsPage(searchValue: "Hand"),transition: Transition.rightToLeft,);
                          doctorController.searchDoctor("Hand");
                        },
                        child: const Categoryicon(
                            icon: Icons.handshake_rounded, text: "Hand")),
                  ],
                ),
                const SizedBox(height: 50),
                StreamBuilder<List<DoctorModel>>(
                  stream: doctorController.getDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No doctors available."));
                    } else {
                      final doctors = snapshot.data!;

                      // Check if there are enough doctors to display
                      if (doctors.length < 4) {
                        return const Center(
                            child: Text("Not enough doctors available."));
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Popular Doctors"),
                              const SizedBox(width: 10),
                              InkWell(
                                  onTap: () {
                                    Get.to(const AllDoctorsPage(),transition: Transition.rightToLeft,);
                                  }, child: const Text("See All")),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Display doctors
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: DoctorCard(doctor: doctors[0])),
                              const SizedBox(width: 20),
                              Expanded(child: DoctorCard(doctor: doctors[1])),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: DoctorCard(doctor: doctors[2])),
                              const SizedBox(width: 20),
                              Expanded(child: DoctorCard(doctor: doctors[3])),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<List<DoctorModel>>(
                  stream: doctorController.getDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No doctors available."));
                    } else {
                      return SizedBox(
                        height: 900, // Set a specific height for the ListView
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10),

                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent nested scrolling
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final doctor = snapshot.data![index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: DoctorTile(
                                doctor: doctor,
                              ),
                            ); // Pass necessary data
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
