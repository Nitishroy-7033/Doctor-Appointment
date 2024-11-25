import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Doctor.dart';
import '../Models/LocalProfile.dart';
import '../Pages/DoctorDetails/DoctorDetails.dart';

class DoctorTile extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorTile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    var localDoctor = LocalProfile.fromJson(doctor.toJson());
    return InkWell(
      onTap: () {
        Get.to(
          DoctorDetailsPage(doctor: localDoctor),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100,
              height: 100,
              child: doctor.profileImage == null || doctor.profileImage!.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        doctor.profileImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  doctor.name!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(doctor.specialization!),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(doctor.rating.toString()),
                    Text("(${doctor.patientNo} Reviews)"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
