import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';

import '../../Controllers/AppointmentController.dart';
import '../../Controllers/ProfileController.dart';
import '../../Models/AppointmentModel.dart';

class AppointmentReport extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentReport({super.key,required this.appointment});

  @override
  Widget build(BuildContext context) {
    BookAppointmentController appointmentController =
        Get.put(BookAppointmentController());
    TextEditingController treatmentDetailsController = TextEditingController(
      text: appointment.treatmentDetails
    );
    TextEditingController treatmentDateController = TextEditingController(
      text: appointment.treatmentDate
    );
  
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text("Appointment Report"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: treatmentDetailsController,
                maxLines: 5,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Tritment Details",
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: treatmentDateController,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.date_range),
                    filled: true,
                    hintText: "Date Time",
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Text("Tritement reports"),
              const SizedBox(height: 20),
             appointment.treatmentImage != null && appointment.treatmentImage!.isNotEmpty
                  ? Container(
                    width: 200,
                    height: 200,
                    child: Image.network(appointment.treatmentImage!)
                  )
                  : Container(
                      color: Colors.white,
                      width: 200,
                      height: 200,
                      child: const Center(
                        child: Text("No reports photo found"),
                      ),),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      )),
    );
  }
}
