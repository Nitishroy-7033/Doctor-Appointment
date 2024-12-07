import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/AppointmentController.dart';
import '../../Controllers/ProfileController.dart';
import '../../Models/AppointmentModel.dart';
import '../../Widgets/DoctorAppointmentCardForUser.dart';

class UserHistory extends StatelessWidget {
  UserHistory({super.key});

  final BookAppointmentController appointmentController = Get.put(BookAppointmentController());
  final ProfileController profileController = Get.put(ProfileController());
  final RxString searchQuery = ''.obs;
  final RxString sortBy = 'Date'.obs; // Default sort by 'Date'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment History"),
        actions: [
          IconButton(
            onPressed: () => searchQuery.value = '', // Clear search on refresh
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Search bar
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: TextField(
            //     onChanged: (value) => searchQuery.value = value.toLowerCase(),
            //     decoration: InputDecoration(
            //       hintText: "Search by doctor name...",
            //       prefixIcon: const Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //   ),
            // ),
            // Sort by dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort By:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: sortBy.value,
                    items: const [
                      DropdownMenuItem(value: 'Date', child: Text("Date")),
                      DropdownMenuItem(value: 'Status', child: Text("Status")),
                    ],
                    onChanged: (value) => sortBy.value = value!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
        
            // Appointment list
            Expanded(
              child: Obx(() {
                return StreamBuilder<List<AppointmentModel>>(
                  stream: appointmentController.getAppointments(profileController.localProfile.value!.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "An error occurred. Please try again.",
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No appointments found.",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }
        
                    // Filter and sort appointments
                    var appointments = snapshot.data!;
                    if (searchQuery.value.isNotEmpty) {
                      appointments = appointments
                          .where((appointment) =>
                              appointment.doctorName!.toLowerCase().contains(searchQuery.value))
                          .toList();
                    }
                    if (sortBy.value == 'Date') {
                      appointments.sort((a, b) => b.date!.compareTo(a.date!)); // Sort by date (descending)
                    } else if (sortBy.value == 'Status') {
                      appointments.sort((a, b) => a.status!.compareTo(b.status!)); // Sort by status
                    }
        
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
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
