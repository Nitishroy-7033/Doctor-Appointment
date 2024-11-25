import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/AuthController.dart';
import '../../Controllers/ProfileController.dart';
import '../UserHistory/UserHistory.dart';
import 'UserProfileEdit.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to( transition: Transition.rightToLeft,
              UserProfileEdit(doctor: profileController.localProfile.value));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Profile"),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () =>
                      profileController
                                        .localProfile.value.profileImage !=
                                    null &&
                                profileController.localProfile.value.profileImage !=
                                    ""
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurple.shade400,
                              ),
                              width: 150,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  profileController
                                      .localProfile.value.profileImage!,
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurple.shade200,
                              ),
                              width: 150,
                              height: 150,
                              child: Icon(Icons.health_and_safety),
                            ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => profileController.localProfile.value.name != null
                  ? Text(
                      profileController.localProfile.value.name!,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )
                  : const SizedBox(),
            ),
            Obx(
              () => profileController.localProfile.value.email != null
                  ? Text(
                      profileController.localProfile.value.email!,
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Text('Settings'),
              ],
            ),
            ListTile(
              splashColor: Colors.deepPurple.shade300,
              onTap: () {
                Get.to(
                  () => const UserHistory(),
                  transition: Transition.rightToLeft,
                );
              },
              leading: const Icon(Icons.book),
              title: const Text("History"),
              trailing: const Icon(Icons.arrow_right),
            ),
            ListTile(
              splashColor: Colors.deepPurple.shade300,
              onTap: () {},
              leading: const Icon(Icons.document_scanner),
              title: const Text("Documents"),
              trailing: const Icon(Icons.arrow_right),
            ),
            ListTile(
              splashColor: Colors.deepPurple.shade300,
              onTap: () {},
              leading: const Icon(Icons.info),
              title: const Text("Help/Supports"),
              trailing: const Icon(Icons.arrow_right),
            ),
            ListTile(
              splashColor: Colors.deepPurple.shade300,
              onTap: () {
                authController.logout();
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_right),
            ),
          ],
        ),
      )),
    );
  }
}
