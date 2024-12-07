import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';
import 'package:myapp/Widgets/MySecondryButton.dart';

import '../../Controllers/AppointmentController.dart';
import '../../Controllers/ProfileController.dart';
import '../../Models/Doctor.dart';
import '../../Models/LocalProfile.dart';
class BookAppointmentPage extends StatelessWidget {
  final LocalProfile doctor;
  BookAppointmentPage({super.key, required this.doctor});

  final BookAppointmentController controller =
      Get.put(BookAppointmentController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
          "Appointment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Doctor's info container (unchanged)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                doctor.profileImage != null &&
                                        doctor.profileImage!.isNotEmpty
                                    ? Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.shade300,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 70,
                                        height: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            doctor.profileImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.shade300,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 70,
                                        height: 70,
                                      ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.name!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(doctor.specialization!),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Slot picker
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select a Slot",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.slots.map((slot) {
                          return GestureDetector(
                            onTap: () {
                              controller.selectedSlot.value = slot;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: controller.selectedSlot.value == slot
                                    ? Colors.deepPurple.shade300
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.deepPurple.shade300,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                slot,
                                style: TextStyle(
                                  color: controller.selectedSlot.value == slot
                                      ? Colors.white
                                      : Colors.deepPurple.shade300,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),

                // Pay now button
                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : MyPrimaryButton(
                        icon: Icons.currency_rupee,
                        text: "Pay now",
                        onPressed: () {
                          controller.bookAppointment(doctor, doctor.id!);
                        },
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
