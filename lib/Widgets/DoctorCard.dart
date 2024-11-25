import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Doctor.dart';
import '../Models/LocalProfile.dart';
import '../Pages/DoctorDetails/DoctorDetails.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    var localDoctor = LocalProfile.fromJson(doctor.toJson());

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(
              DoctorDetailsPage(doctor: localDoctor),
              transition: Transition.rightToLeft,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: doctor.profileImage == null ||
                      doctor.profileImage!.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    )
                  : Image.network(
                      doctor.profileImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          size: 80,
                          color: Colors.red,
                        );
                      },
                    ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          doctor.name!,
          style: const TextStyle(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
