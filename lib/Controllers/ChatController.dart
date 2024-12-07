import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../Models/ChatModel.dart';

class ChatController extends GetxController {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  // Load messages from Firestore
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return db
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessage.fromJson(doc.data()))
          .toList();
    });
  }

  // Send a message
  Future<void> sendMessage(String chatId, String message, String senderId, String receiverId) async {
    final messageId = db.collection("chats").doc(chatId).collection("messages").doc().id;

    final chatMessage = ChatMessage(
      id: messageId,
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: DateTime.now(),
    );

    await db
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .set(chatMessage.toJson());
  }

  // Send an image
  Future<void> sendImage(String chatId, File image, String senderId, String receiverId) async {
    try {
      final imageId = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = storage.ref().child('chat_images').child('$chatId/$imageId.jpg');

      // Upload image to Firebase Storage
      final uploadTask = await ref.putFile(image);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Send image message
      final messageId = db.collection("chats").doc(chatId).collection("messages").doc().id;
      final chatMessage = ChatMessage(
        id: messageId,
        senderId: senderId,
        receiverId: receiverId,
        message: '',
        imageUrl: imageUrl,
        timestamp: DateTime.now(),
      );

      await db
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .doc(messageId)
          .set(chatMessage.toJson());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
