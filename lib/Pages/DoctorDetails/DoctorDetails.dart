import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Pages/AppointmentBook/AppointmentBook.dart';
import '../../Controllers/ProfileController.dart';
import '../../Controllers/ReviewController.dart';
import '../../Models/Doctor.dart';
import '../../Models/LocalProfile.dart';
import '../../Models/ReviewModel.dart';
import '../../Widgets/NotificationWidget.dart';

class DoctorDetailsPage extends StatelessWidget {
  final LocalProfile doctor;
  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    ReviewController reviewController = Get.put(ReviewController());
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController reviewText = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(
             BookAppointmentPage(doctor: doctor),
            transition: Transition.rightToLeft,
          );
        },
        icon: const Icon(Icons.book),
        label: const Text("Book"),
      ),
      appBar: AppBar(
        title: Text(doctor.name!),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    doctor.profileImage != null && doctor.profileImage!.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(doctor.profileImage!)),
                            width: 120,
                            height: 120,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.deepPurple,
                            ),
                            width: 120,
                            height: 120,
                          ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          doctor.specialization!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          "${doctor.price}/hr",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${doctor.experience} Years",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Experiance",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${doctor.patientNo}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Patients",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${doctor.rating}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                // Suggested code may be subject to a license. Learn more: ~LicenseLog:3203526212.
                const Row(
                  children: [
                    Text("About Doctor"),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        doctor.aboutUs!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text("Clinic Address"),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_city),
                    Text(doctor.clinicAddress!),
                  ],
                ),
                const Text("560008"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Reviews "),
                    ElevatedButton(
                        onPressed: () {
                          Get.bottomSheet(Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 300,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text("Add Review"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: reviewText,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          hintText: "Write your review here",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (reviewText.text != "") {
                                            reviewController.addReview(
                                                doctor.id!,
                                                reviewText.text,
                                                profileController
                                                    .localProfile.value);
                                            Get.back();
                                          } else {
                                            errorMessage(
                                                "Please write a review");
                                          }
                                        },
                                        child: const Text("Submit Review"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                        },
                        child: const Text("add review")),
                  ],
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<ReviewModel>>(
                  stream: reviewController.getReviews(doctor.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Something went wrong. Please try again later.",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No reviews yet",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final review = snapshot.data![index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: review.userImage != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                review.userImage!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey,
                                                  size: 30,
                                                ),
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person,
                                              size: 30,
                                              color: Colors.deepPurple,
                                            ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        review.userName ?? "Anonymous",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  review.review ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
