import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Models/Doctor.dart';
import '../Models/LocalProfile.dart';
import '../Models/NotificationModel.dart';
import '../Models/ReviewModel.dart';
import '../Models/User.dart';
import '../Widgets/NotificationWidget.dart';
import 'NotificationController.dart';

class ReviewController extends GetxController{

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = const Uuid();
  NotificationController notificationController = Get.put(NotificationController());
  Future<void> addReview(String doctorId,String review, LocalProfile user)async{
    

    var id = uuid.v4();
   try{
     var reviewModel = ReviewModel(
      id: id,
      doctorId: doctorId,
      review: review,
      userId: auth.currentUser!.uid,
      userName: user.name,
      userImage: user.profileImage,
      createdAt: DateTime.now().toString(),
    );
    await db.collection("doctors").doc(doctorId).collection("reviews").doc(id).set(reviewModel.toJson());
    successMessage("Review added successfully");
     var notification = NotificationModel(
        id: uuid.v4(),
        title: "Review Added",
        description: "Your review has been added successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
   }catch(e){
    errorMessage("Something went wrong");
   }
    
  }

  Stream<List<ReviewModel>> getReviews(String doctorId){
    return db.collection("doctors")
    .doc(doctorId)
    .collection("reviews")
    .snapshots().map((event) => event.docs.map((e) => ReviewModel.fromJson(e.data())).toList(),);
  }
}