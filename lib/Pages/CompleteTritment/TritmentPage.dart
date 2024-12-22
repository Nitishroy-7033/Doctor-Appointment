import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Widgets/MyPrimaryButton.dart';

import '../../Controllers/AppointmentController.dart';
import '../../Controllers/ProfileController.dart';
import '../../Models/AppointmentModel.dart';

class DoctorTritmentPage extends StatelessWidget {
  final AppointmentModel appointment;
  const DoctorTritmentPage({super.key,required this.appointment});

  @override
  Widget build(BuildContext context) {
    BookAppointmentController appointmentController =
        Get.put(BookAppointmentController());
    TextEditingController treatmentDetailsController = TextEditingController();
    TextEditingController treatmentDateController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    Rx<XFile?> treatmentImage = Rx<XFile?>(null);
    RxBool isLoading = RxBool(false);
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text("Treatment "),
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
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Treatment  Details",
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: treatmentDateController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.time_to_leave),
                    filled: true,
                    hintText: "Date Time",
                    border: UnderlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Text("Tritement reports"),
              const SizedBox(height: 20),
              Obx(() => treatmentImage.value != null
                  ? InkWell(
                    onTap: () async{
                   treatmentImage.value = await profileController.pickupImage();
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.file(
                          File(treatmentImage.value!.path),
                          width: 200,
                          height: 150,
                        ),
                    ),
                  )
                  : InkWell(
                    onTap: () async{
                   treatmentImage.value = await profileController.pickupImage();
                    },
                    child: Container(
                        color: Colors.white,
                        width: 200,
                        height: 200,
                        child: const Center(
                          child: Text("Add Photo"),
                        ),),
                  ),),
              const SizedBox(height: 20),
              Obx(()=> isLoading.value ? const Center(child: CircularProgressIndicator(),) : MyPrimaryButton(
                icon: Icons.save,
                text: "Complete",
                onPressed: () async {
                  isLoading.value = true;
                  var tritmentUrl = await profileController.uploadImageToFirebaseStorage(treatmentImage.value!);
                  appointmentController.completeTreatment(appointment, treatmentDetailsController.text, treatmentDateController.text, tritmentUrl!);
                  isLoading.value = false;
                  Get.back();
                },
              ))
            ],
          ),
        ),
      )),
    );
  }
}
