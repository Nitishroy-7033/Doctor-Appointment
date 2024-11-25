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

  // Initialize the controller
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
                                doctor.profileImage != null && doctor.profileImage!.isNotEmpty ? Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(doctor.profileImage!,fit: BoxFit.cover,),
                                  ),
                                ) : Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(10),
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
                            // const SizedBox(height: 20),
                            // Container(
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //     color: Colors.deepPurple.shade100
                            //         .withOpacity(0.5),
                            //   ),
                            //   child: const Row(
                            //     children: [
                            //       Icon(Icons.info),
                            //       SizedBox(width: 10),
                            //       Text("Be available before 30 min")
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Date and Time pickers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return MySecondaryButton(
                        icon: Icons.calendar_view_month,
                        text: controller.selectedDate.value != null
                            ? "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}"
                            : "Select Date",
                        onPressed: () => controller.pickDate(context),
                      );
                    }),
                    Obx(() {
                      return MySecondaryButton(
                        icon: Icons.lock_clock_sharp,
                        text: controller.selectedTime.value != null
                            ? controller.selectedTime.value!.format(context)
                            : "Select Time",
                        onPressed: () => controller.pickTime(context),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10),

                // Payment info container (unchanged)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment Info"),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Doctor Fee"),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Colors.deepPurple,
                                      size: 28,
                                    ),
                                    Text(
                                      doctor.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Other fee"),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Colors.deepPurple,
                                      size: 28,
                                    ),
                                    Text(
                                      "00.00",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 10,
                              thickness: 2,
                              color: Colors.deepPurple,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Fee"),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      color: Colors.deepPurple,
                                      size: 28,
                                    ),
                                    Text(
                                      doctor.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                const SizedBox(height: 40),

                // Pay now button
                Obx(() => controller.isLoading.value ? Center(child: CircularProgressIndicator()) : MyPrimaryButton(
                  icon: Icons.currency_rupee,
                  text: "Pay now",
                  onPressed: () {
                    controller.bookAppointment(doctor,doctor.id!);
                  },
                )),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
