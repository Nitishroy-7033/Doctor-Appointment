import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Models/NotificationModel.dart';
import '../Widgets/NotificationWidget.dart';
import '../configs/constant.dart';

class NotificationController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = const Uuid();

  Future<void> addNotification(NotificationModel notification) async {
    try {
      var id = uuid.v4();
      notification.id = id;
      await db.collection("users").doc(auth.currentUser!.uid).collection("notifications").doc(id).set(notification.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String role = prefs.getString(ROLE) ?? "";
      if (role == "doctor") {
        await db
            .collection("doctors")
            .doc(auth.currentUser!.uid)
            .collection("notifications")
            .doc(id)
            .set(notification.toJson());
      } else {
        await db
            .collection("users")
            .doc(auth.currentUser!.uid)
            .collection("notifications")
            .doc(id)
            .set(notification.toJson());
      }
      successMessage("Notification added successfully");
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  Stream<List<NotificationModel>> getNotifications(String id) {
    return db.collection("users").doc(auth.currentUser!.uid).collection("notifications").snapshots().map((event) => event.docs.map((e) => NotificationModel.fromJson(e.data())).toList(),);
  }
}
