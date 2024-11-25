import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controllers/AppointmentController.dart';
import 'package:myapp/Pages/CompleteTritment/TritmentPage.dart';

import '../../Controllers/ProfileController.dart';
import '../../Models/AppointmentModel.dart';
import '../../Widgets/DockerAppointmentCardforDoctor.dart';
import '../../Widgets/DoctorAppointmentCardForUser.dart';

class DoctorAppointmentHistory extends StatelessWidget {
  final String id;
  const DoctorAppointmentHistory({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    BookAppointmentController appointmentController = Get.put(BookAppointmentController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text("Appointment History"),
      ),
      body: SafeArea(
          child: Padding(
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
                      child: DockerAppointmentCardForDoctor(
                        appointment: appointments[index],
                      ),
                    );
                  },
                );
              }
            },
                    ),
          )),
    );
  }
}
