import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Models/Doctor.dart';
import 'package:myapp/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/LocalProfile.dart';
import '../Widgets/NotificationWidget.dart';
import '../configs/constant.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Rx<LocalProfile> localProfile = LocalProfile().obs;
  @override
  void onInit() {
    super.onInit();
    fetchDoctorProfile();
  }

  Future<void> fetchDoctorProfile() async {
    try {
      isLoading.value = true;
      var user = auth.currentUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String role = prefs.getString(ROLE) ?? "";
      if (role == "doctor") {
        var doc = await db.collection('doctors').doc(user?.uid).get();
        var profile = LocalProfile(
          aboutUs: doc.data()?["aboutUs"],
          clinicAddress: doc.data()?["clinicAddress"],
          contactNumber: doc.data()?["contactNumber"],
          email: doc.data()?["email"],
          experience: doc.data()?["experience"],
          id: doc.data()?["id"],
          name: doc.data()?["name"],
          patientNo: doc.data()?["patientNo"],
          price: doc.data()?["price"],
          profileImage: doc.data()?["profileImage"],
          qualification: doc.data()?["qualification"],
          role: doc.data()?["role"],
          specialization: doc.data()?["specialization"],
          timings: doc.data()?["timings"],
          userName: doc.data()?["userName"],
          hashPassword: doc.data()?["hashPassword"],
          phoneNumber: doc.data()?["phoneNumber"],
          rating: doc.data()?["rating"],
        );
        localProfile.value = profile;
      } else {
        var doc = await db.collection('users').doc(user?.uid).get();
        var profile = LocalProfile.fromJson(doc.data() ?? {});
        localProfile.value = profile;
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDoctorProfile(DoctorModel doctor) async {
    try {
      isLoading.value = true;
      await db
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update(doctor.toJson());
      isLoading.value = false;
      successMessage("Profile updated successfully");
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      isLoading.value = true;
      await db
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update(user.toJson());
      isLoading.value = false;
      successMessage("Profile updated successfully");
      Get.back();
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  /// Function to pick an image using ImagePicker
  Future<XFile?> pickupImage() async {
    try {
      // Pick an image
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        errorMessage("No image selected.");
        return null;
      }

      return pickedFile; // Return the selected image
    } catch (e) {
      errorMessage("Error picking image: ${e.toString()}");
      return null;
    }
  }

  /// Function to upload an image to Firebase Storage and get its URL
  Future<String?> uploadImageToFirebaseStorage(XFile file) async {
    try {
      // Define a unique filename
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(File(file.path));
      await uploadTask;

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();
      print("Image uploaded. URL: $downloadURL");
      successMessage("Image uploaded successfully");

      return downloadURL;
    } catch (e) {
      errorMessage("Error uploading image: ${e.toString()}");
      return null;
    }
  }
}
