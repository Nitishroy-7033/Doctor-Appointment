import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/AppointmentController.dart';
import '../../Controllers/ProfileController.dart';
import '../../Models/AppointmentModel.dart';
import '../../Widgets/DoctorAppointmentCardForUser.dart';

class UserHistory extends StatelessWidget {
  const UserHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final BookAppointmentController appointmentController = Get.put(BookAppointmentController());
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            onPressed: () {
              // Refresh appointments or reload the page
              // appointmentController.refreshAppointments();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<List<AppointmentModel>>(
          stream: appointmentController.getAppointments(profileController.localProfile.value!.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No appointments found."));
            } else {
              final appointments = snapshot.data!;
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: DoctorAppointmentCardForUser(
                      appointment: appointments[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
