import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../Models/DocumentModel.dart';

class DocumentController extends GetxController {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  RxList<DocumentModel> documents = <DocumentModel>[].obs;

  // Fetch documents for a user/doctor
  Stream<List<DocumentModel>> fetchDocuments(String userId) {
    return db
        .collection("documents")
        .doc(userId)
        .collection("user_documents")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DocumentModel.fromJson(doc.data()))
          .toList();
    });
  }

  // Upload document
  Future<void> uploadDocument(String userId, File image, String title) async {
    try {
      final documentId = db.collection("documents").doc(userId).collection("user_documents").doc().id;

      // Upload the image to Firebase Storage
      final ref = storage.ref().child('documents').child('$userId/$documentId.jpg');
      final uploadTask = await ref.putFile(image);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Save document details to Firestore
      final document = DocumentModel(
        id: documentId,
        title: title,
        imageUrl: imageUrl,
        timestamp: DateTime.now(),
      );

      await db
          .collection("documents")
          .doc(userId)
          .collection("user_documents")
          .doc(documentId)
          .set(document.toJson());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
