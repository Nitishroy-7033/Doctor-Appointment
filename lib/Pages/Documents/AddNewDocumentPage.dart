import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/DocumentController.dart';

class UploadDocumentDialog extends StatefulWidget {
  final String userId;

  const UploadDocumentDialog({super.key, required this.userId});

  @override
  State<UploadDocumentDialog> createState() => _UploadDocumentDialogState();
}

class _UploadDocumentDialogState extends State<UploadDocumentDialog> {
  final TextEditingController titleController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final DocumentController documentController = Get.find<DocumentController>();

    return AlertDialog(
      title: const Text("Upload Document"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Enter document title"),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  selectedImage = File(pickedFile.path);
                });
              }
            },
            icon: const Icon(Icons.image),
            label: const Text("Select Image"),
          ),
          if (selectedImage != null)
            Image.file(
              selectedImage!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.trim().isEmpty || selectedImage == null) {
              Get.snackbar("Error", "Please provide both a title and an image.");
              return;
            }
            documentController.uploadDocument(widget.userId, selectedImage!, titleController.text.trim());
            Navigator.pop(context);
          },
          child: const Text("Upload"),
        ),
      ],
    );
  }
}
