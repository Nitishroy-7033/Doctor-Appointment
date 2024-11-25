import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/Auth/UserLogin.dart';
import 'package:myapp/Pages/HomePage/Homepage.dart';

class SplaceController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    handleSplashNavigation();
  }

  /// Handles splash screen navigation logic
  Future<void> handleSplashNavigation() async {
    try {
      await Future.delayed(const Duration(seconds: 5)); // Simulate splash delay

      // Check if user is authenticated
      if (auth.currentUser != null) {
        Get.offAll(() => const HomePage()); // Navigate to HomePage
      } else {
        Get.offAll(() => const UserLogin()); // Navigate to UserLogin
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while navigating: $e');
    }
  }
}
