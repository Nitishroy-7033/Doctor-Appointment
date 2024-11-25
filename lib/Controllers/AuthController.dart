import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/Auth/DoctorLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Models/Doctor.dart';
import '../Models/NotificationModel.dart';
import '../Models/User.dart';
import '../Pages/Auth/UserLogin.dart';
import '../Pages/HomePage/Homepage.dart';
import '../Widgets/NotificationWidget.dart';
import '../configs/constant.dart';
import 'NotificationController.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = const Uuid();
  RxBool isLoading = false.obs;
  NotificationController notificationController = Get.put(NotificationController());
  Future<void> createUserAccountAsync(
      String name, String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String firebaseUserId = userCredential.user!.uid;
      String hashedPassword = sha256.convert(utf8.encode(password)).toString();

      var user = UserModel(
        id: firebaseUserId,
        name: name,
        userName: name.toLowerCase().replaceAll(' ', '_'),
        hashPassword: hashedPassword,
        email: email,
        phoneNumber: '',
        profileImage: '',
        role: "user",
      );

      await db.collection('users').doc(firebaseUserId).set(user.toJson());
       var notification = NotificationModel(
        id: uuid.v4(),
        title: "User Account Created",
        description: "Your user account has been created successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
      successMessage("User account created successfully!");
      Get.offAll(const UserLogin());
    } on FirebaseAuthException catch (ex) {
      errorMessage(ex.message.toString());
    } catch (ex) {
      errorMessage(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createDoctorAccountAsync(String name, String email,
      String password, String specialization, String price) async {
    try {
      isLoading.value = true;

      var existingDoctor = await db
          .collection('doctors')
          .where('email', isEqualTo: email)
          .get();
      if (existingDoctor.docs.isNotEmpty) {
        errorMessage('The email is already registered as a doctor!');
        return;
      }

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String firebaseUserId = userCredential.user!.uid;
      String hashedPassword = sha256.convert(utf8.encode(password)).toString();

      var doctor = DoctorModel(
        id: firebaseUserId,
        name: name,
        patientNo: 0,
        clinicAddress: '',
        aboutUs: '',
        experience: 0,
        rating: 0,
        email: email,
        userName: name.toLowerCase().replaceAll(' ', '_'),
        hashPassword: hashedPassword,
        contactNumber: '',
        profileImage: '',
        role: "doctor",
        specialization: specialization,
        price: price,
        timings: "All Day",
        qualification: "",
      );

      await db.collection('doctors').doc(firebaseUserId).set(doctor.toJson());

      successMessage("Doctor account created successfully!");
       var notification = NotificationModel(
        id: uuid.v4(),
        title: "Doctor Account Created",
        description: "Your doctor account has been created successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
      Get.offAll(const DoctorLogin());
    } on FirebaseAuthException catch (ex) {
      errorMessage(ex.message.toString());
    } catch (ex) {
      errorMessage(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUserAsync(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String firebaseUserId = userCredential.user!.uid;

      DocumentSnapshot userDoc =
          await db.collection('users').doc(firebaseUserId).get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        var user = UserModel.fromJson(userData);

        successMessage('Logged in as ${user.name}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(ROLE, user.role ?? "");

        Get.offAll(() => const HomePage());
      } else {
        errorMessage('User data not found.');
        auth.signOut();
      }
    } on FirebaseAuthException catch (ex) {
      errorMessage(ex.message.toString());
    } catch (ex) {
      errorMessage(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginDoctorAsync(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String firebaseUserId = userCredential.user!.uid;

      DocumentSnapshot doctorDoc =
          await db.collection('doctors').doc(firebaseUserId).get();

      if (doctorDoc.exists) {
        var doctorData = doctorDoc.data() as Map<String, dynamic>;
        var doctor = DoctorModel.fromJson(doctorData);

        successMessage('Logged in as Dr. ${doctor.name}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(ROLE, doctor.role ?? "");

        Get.offAll(() => const HomePage());
      } else {
        errorMessage('Doctor data not found.');
        auth.signOut();
      }
    } on FirebaseAuthException catch (ex) {
      errorMessage(ex.message.toString());
    } catch (ex) {
      errorMessage(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try{
      isLoading.value = true;
    await auth.sendPasswordResetEmail(email: email);
      successMessage("Password reset email sent!");
    } on FirebaseAuthException catch (ex) {
      errorMessage(ex.message.toString());
    } catch (ex) {
      errorMessage(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

   Future<void> logout() async {
    await auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ROLE, "");
    Get.offAll(() => const UserLogin());
    successMessage("Logged out successfully!");
     var notification = NotificationModel(
        id: uuid.v4(),
        title: "Logged Out",
        description: "You have been logged out successfully",
        createdAt: DateTime.now().toIso8601String(),
      );
      notificationController.addNotification(notification);
  }
}
