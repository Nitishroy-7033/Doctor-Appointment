import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:myapp/Widgets/NotificationWidget.dart';
import 'package:uuid/uuid.dart';

import '../Models/AppointmentModel.dart';
import '../Models/LocalProfile.dart';
import '../Models/NotificationModel.dart';
import 'NotificationController.dart';
import 'ProfileController.dart';
import 'RoleController.dart';

class BookAppointmentController extends GetxController {
  RoleController roleController = Get.put(RoleController());
  RxBool isLoading = false.obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Rx<DateTime?> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay?> selectedTime = TimeOfDay.now().obs;
  var uuid = const Uuid();
   RxList<String> slots = [
    "9:00 AM - 9:30 AM",
    "10:00 AM - 10:30 AM",
    "11:00 AM - 11:30 AM",
    "12:00 PM - 12:30 PM",
    "2:00 PM - 2:30 PM",
    "3:00 PM - 3:30 PM",
    "4:00 PM - 4:30 PM",
  ].obs;

  // Selected slot
  RxString selectedSlot = "".obs;
  NotificationController notificationController =
      Get.put(NotificationController());

  ProfileController profileController = Get.put(ProfileController());




Future<void> bookAppointment(LocalProfile doctor, String targetDoctorId) async {
    try {
      if (selectedSlot.value.isEmpty) {
        errorMessage("Please select a slot.");
        return;
      }

      isLoading.value = true;
      var id = uuid.v4();
      var appointment = AppointmentModel(
        id: id,
        status: "Booked",
        doctorId: doctor.id,
        userId: profileController.localProfile.value!.id!,
        doctorName: doctor.name,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        doctorSpecialization: doctor.specialization,
        doctorProfileImage: doctor.profileImage,
        date: getFormattedDate(), // Formatted date
        time: selectedSlot.value, // Selected slot
        amount: doctor.price.toString(),
        userName: profileController.localProfile.value!.name,
        userProfileImage: profileController.localProfile.value!.profileImage,
        treatmentDetails: "",
        treatmentDate: "",
        treatmentImage: "",
      );

      await db.collection("appointments").doc(id).set(appointment.toJson());

      // Store appointment for user or doctor
      roleController.role.value == "user"
          ? await db
              .collection("users")
              .doc(profileController.localProfile.value!.id!)
              .collection("appointments")
              .doc(id)
              .set(appointment.toJson())
          : await db
              .collection("doctors")
              .doc(profileController.localProfile.value!.id!)
              .collection("appointments")
              .doc(id)
              .set(appointment.toJson());

      // Store appointment under target doctor's collection
      await db
          .collection("doctors")
          .doc(targetDoctorId)
          .collection("appointments")
          .doc(id)
          .set(appointment.toJson());

      successMessage("Appointment booked successfully");

      var notification = NotificationModel(
        id: uuid.v4(),
        title: "Appointment Booked",
        description:
            "Your appointment with ${doctor.name} at ${selectedSlot.value} has been booked successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading.value = false;
    }
  }




  // Function to pick a date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  // Function to pick a time
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value!,
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
    }
  }

  // Function to format the selected date
  String getFormattedDate() {
    if (selectedDate.value != null) {
      return DateFormat('yyyy-MM-dd')
          .format(selectedDate.value!); // Format: YYYY-MM-DD
    }
    return '';
  }

  // Function to format the selected time
  String getFormattedTime() {
    if (selectedTime.value != null) {
      final now = DateTime.now();
      final time = DateTime(now.year, now.month, now.day,
          selectedTime.value!.hour, selectedTime.value!.minute);
      return DateFormat('hh:mm a').format(time); // Format: HH:MM AM/PM
    }
    return '';
  }

  // Future<void> bookAppointment(LocalProfile doctor,String targetDoctorId) async {
  //   try {
  //     isLoading.value = true;
  //     var id = uuid.v4();
  //     var appointment = AppointmentModel(
  //       id: id,
  //       status: "Booked",
  //       doctorId: doctor.id,
  //       userId: profileController.localProfile.value!.id!,
  //       doctorName: doctor.name,
  //       createdAt: DateTime.now().toIso8601String(),
  //       updatedAt: DateTime.now().toIso8601String(),
  //       doctorSpecialization: doctor.specialization,
  //       doctorProfileImage: doctor.profileImage,
  //       date: getFormattedDate(), // Formatted date
  //       time: getFormattedTime(), // Formatted time
  //       amount: doctor.price.toString(),
  //       userName: profileController.localProfile.value!.name,
  //       userProfileImage: profileController.localProfile.value!.profileImage,
  //       treatmentDetails: "",
  //       treatmentDate: "",
  //       treatmentImage: "",
  //     );
  //     await db.collection("appointments").doc(id).set(appointment.toJson());
  //     roleController.role.value == "user" ?
  //     await db
  //         .collection("users")
  //         .doc(profileController.localProfile.value!.id!)
  //         .collection("appointments")
  //         .doc(id)
  //         .set(appointment.toJson()) :
  //     await db
  //         .collection("doctors")
  //         .doc(profileController.localProfile.value!.id!)
  //         .collection("appointments")
  //         .doc(id)
  //         .set(appointment.toJson());

  //         await db
  //         .collection("doctors")
  //         .doc(targetDoctorId)
  //         .collection("appointments")
  //         .doc(id)
  //         .set(appointment.toJson());
  //     successMessage("Appointment booked successfully");
  //     var notification = NotificationModel(
  //       id: uuid.v4(),
  //       title: "Appointment Booked",
  //       description:
  //           "Your appointment with ${doctor.name} has been booked successfully",
  //       createdAt: DateTime.now().toIso8601String(),
  //     );
  //     notificationController.addNotification(notification);
  //   } catch (e) {
  //     errorMessage(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Stream<List<AppointmentModel>> getAppointments(String id) {
    if (roleController.role.value == "user") {
      return db
          .collection("users")
          .doc(id)
          .collection("appointments")
          .snapshots()
          .map((event) => event.docs
              .map((e) => AppointmentModel.fromJson(e.data()))
              .toList());
    } else {
      return db
          .collection("doctors")
          .doc(id)
          .collection("appointments")
          .snapshots()
          .map((event) => event.docs
              .map((e) => AppointmentModel.fromJson(e.data()))
              .toList());
    }
  }

  Future<void> updatedStatus(AppointmentModel appointment, String status,String targetDoctorId) async {
    await db
        .collection("appointments")
        .doc(appointment.id!)
        .update({"status": status});
    roleController.role.value=="user" ?
    await db
        .collection("users")
        .doc(profileController.localProfile.value!.id!)
        .collection("appointments")
        .doc(appointment.id!)
        .update({"status": status}):
    await db
        .collection("doctors")
        .doc(profileController.localProfile.value!.id!)
        .collection("appointments")
        .doc(appointment.id!)
        .update({"status": status});

    await db
        .collection("doctors")
        .doc(targetDoctorId)
        .collection("appointments")
        .doc(appointment.id!)
        .update({"status": status});
    var notification = NotificationModel(
      id: uuid.v4(),
      title: "Appointment Status Updated",
      description: "Your appointment status has been updated to $status",
      createdAt: DateTime.now().toIso8601String(),
    );
    notificationController.addNotification(notification);
  }

  Future<void> completeTreatment(
      AppointmentModel appointment,
      String treatmentDetails,
      String treatmentDate,
      String treatmentImage) async {
    await db.collection("appointments").doc(appointment.id).update({
      "treatmentDetails": treatmentDetails,
      "treatmentDate": treatmentDate,
      "treatmentImage": treatmentImage,
      "status": "Completed"
    });
    await db
        .collection("users")
        .doc(appointment.userId!)
        .collection("appointments")
        .doc(appointment.id!)
        .update({
      "treatmentDetails": treatmentDetails,
      "treatmentDate": treatmentDate,
      "treatmentImage": treatmentImage,
      "status": "Completed"
    });

    await db
        .collection("doctors")
        .doc(appointment.doctorId!)
        .collection("appointments")
        .doc(appointment.id!)
        .update({
      "treatmentDetails": treatmentDetails,
      "treatmentDate": treatmentDate,
      "treatmentImage": treatmentImage,
      "status": "Completed"
    });
    successMessage("Treatment completed successfully");
      var notification = NotificationModel(
        id: uuid.v4(),
        title: "Treatment Completed",
        description:
            "Your treatment has been completed successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
  }
}
