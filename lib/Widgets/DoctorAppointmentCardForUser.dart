import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/ProfileController.dart';

import '../Controllers/AppointmentController.dart';
import '../Models/AppointmentModel.dart';
import '../Pages/AppointmentReport/AppointmentReport.dart';
import '../Pages/ChatPage/ChatPage.dart';

class DoctorAppointmentCardForUser extends StatelessWidget {
  final AppointmentModel appointment;
  const DoctorAppointmentCardForUser({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    BookAppointmentController appointmentController =
        Get.put(BookAppointmentController());
    return InkWell(
      onTap: () {
        if (appointment.status == "Completed") {
          Get.to(
            AppointmentReport(appointment: appointment),
            transition: Transition.rightToLeft,
          );
        } else {
          Get.to(() => ChatPage(
                chatId:
                    '${appointment.userId}_${appointment.doctorId}', // Unique chat ID
                senderId: profileController.localProfile.value!.id!,
                receiverId: appointment.doctorId!,
              ));
        }
      },
      child: Container(
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
                      appointment.doctorProfileImage != null &&
                              appointment.doctorProfileImage!.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 70,
                              height: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    appointment.doctorProfileImage!,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 70,
                              height: 70,
                              child: Icon(Icons.broken_image_rounded),
                            ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.doctorName ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(appointment.doctorSpecialization ?? ""),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lock_clock_rounded,
                              size: 25,
                            ),
                            Text(
                              appointment.time ?? "",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 25,
                            ),
                            Text(
                              appointment.date ?? "",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      appointment.status == "cancelled"
                          ? const Text(
                              "Cancelled",
                              style: TextStyle(color: Colors.red),
                            )
                          : appointment.status == "Completed"
                              ? ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                      AppointmentReport(
                                          appointment: appointment),
                                      transition: Transition.rightToLeft,
                                    );
                                  },
                                  child: Text("Reports"))
                              : ElevatedButton(
                                  onPressed: () {
                                    appointmentController.updatedStatus(
                                        appointment,
                                        "cancelled",
                                        appointment.doctorId!);
                                  },
                                  child: const Text("Cancel"),
                                ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
