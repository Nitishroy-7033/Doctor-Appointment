import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/DoctorController.dart';
import '../../Models/Doctor.dart';
import '../../Widgets/DoctorTile.dart';

class AllDoctorsPage extends StatelessWidget {
  final String? searchValue;
  const AllDoctorsPage({super.key, this.searchValue});

  @override
  Widget build(BuildContext context) {
    DoctorController doctorController = Get.put(DoctorController());
    TextEditingController searchController = TextEditingController(text: searchValue);

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
          "Doctors",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          doctorController.searchDoctor(value);
                        },
                        decoration: const InputDecoration(
                          hintText: "Search name or specialization",
                          contentPadding: EdgeInsets.all(10),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [Text("All Doctors")],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {
                  if (doctorController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (doctorController.doctors.isEmpty) {
                    return const Center(child: Text('No doctors available'));
                  }
                  return ListView.builder(
                    itemCount: doctorController.doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorController.doctors[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DoctorTile(doctor: doctor),
                );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
