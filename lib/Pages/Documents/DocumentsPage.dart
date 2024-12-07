import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Pages/Documents/ImageView.dart';
import '../../Controllers/DocumentController.dart';
import '../../Models/DocumentModel.dart';
import 'AddNewDocumentPage.dart';

class DocumentPage extends StatelessWidget {
  final String userId; // Pass the user/doctor ID
  final DocumentController documentController = Get.put(DocumentController());

  DocumentPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Documents List
            Expanded(
              child: StreamBuilder<List<DocumentModel>>(
                stream: documentController.fetchDocuments(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No documents found."));
                  } else {
                    final documents = snapshot.data!;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return InkWell(
                          onTap: (){
                            Get.to(ImageViewerPage(imageUrl: document.imageUrl, title: document.title));
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                                  
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(document.imageUrl,width: 100,height: 100,fit: BoxFit.cover,))  ,
                                  
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(document.title),
                              Text(document.timestamp.toString()),
                            ],)
                          ],),),
                        );
                      },
                    );
                  }
                },
              ),
            ),
        
            // Upload Document Button
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Open a dialog to get title and image
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return UploadDocumentDialog(userId: userId);
                    },
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Document"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
