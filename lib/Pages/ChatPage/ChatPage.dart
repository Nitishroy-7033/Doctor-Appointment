import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../Controllers/ChatController.dart';
import '../../Models/ChatModel.dart';
class ChatPage extends StatelessWidget {
  final String chatId;
  final String senderId;
  final String receiverId;
  final ChatController chatController = Get.put(ChatController());

  ChatPage({super.key, required this.chatId, required this.senderId, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Messages List
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: chatController.getMessages(chatId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No messages yet."));
                  } else {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId == senderId;
        
                        return Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: message.imageUrl.isNotEmpty
                                ? Image.network(message.imageUrl, width: 150, height: 150)
                                : Text(message.message, style: const TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
        
            // Message Input and Send Button
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10)
            ),
            child:  Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final file = File(pickedFile.path);
                        chatController.sendImage(chatId, file, senderId, receiverId);
                      }
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration:  InputDecoration(
                        filled: false,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        hintText: "Type a message...",
                        
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        chatController.sendMessage(chatId, messageController.text, senderId, receiverId);
                        messageController.clear();
                      }
                    },
                  ),
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
