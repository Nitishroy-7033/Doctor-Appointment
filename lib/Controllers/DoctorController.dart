import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Models/Doctor.dart';
import '../Widgets/NotificationWidget.dart';

class DoctorController extends GetxController {
  final db = FirebaseFirestore.instance;
  RxList<DoctorModel> doctors = <DoctorModel>[].obs;
  RxList<DoctorModel> searchDoctors = <DoctorModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> addDoctorAsync(DoctorModel doctor) async {
    // Validate required fields
    if (doctor.id == null || doctor.id!.isEmpty) {
      errorMessage("Doctor ID is required.");
      return;
    }
    if (doctor.name == null || doctor.name!.isEmpty) {
      errorMessage("Doctor name is required.");
      return;
    }
    if (doctor.specialization == null || doctor.specialization!.isEmpty) {
      errorMessage("Doctor specialization is required.");
      return;
    }
    if (doctor.price == null || doctor.price!.isEmpty) {
      errorMessage("Consultation price is required.");
      return;
    }

    try {
      await db.collection('doctors').doc(doctor.id).set(doctor.toJson());
      successMessage("Doctor added successfully.");
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  Future<void> addDemoDoctors() async {
    List<DoctorModel> demoDoctors = [
      DoctorModel(
        id: "doc001",
        name: "Dr. John Doe",
        userName: "johndoe",
        hashPassword: "hashed_password_1",
        qualification: "MBBS, MD",
        specialization: "Cardiologist",
        experience: 10,
        rating: 4.8,
        contactNumber: "1234567890",
        email: "johndoe@example.com",
        timings: "10:00 AM - 4:00 PM",
        profileImage:
            "https://th.bing.com/th/id/R.256ff89b8455578cb07f46a207a4d6ae?rik=wamzqu6ozFnjjw&riu=http%3a%2f%2fwww.publicdomainpictures.net%2fpictures%2f210000%2fvelka%2fdoctor-1490804643Rfi.jpg&ehk=xVsfwkQ4RsL0lPNklpn0uYssY%2fJJqHho%2bhw1KPmGMXU%3d&risl=&pid=ImgRaw&r=0",
        clinicAddress: "123 Heart Lane, Health City",
        aboutUs: "Experienced cardiologist with 10 years of expertise.",
        price: "1000",
        role: "Doctor",
        patientNo: 120,
      ),
      DoctorModel(
        id: "doc002",
        name: "Dr. Jane Smith",
        userName: "janesmith",
        hashPassword: "hashed_password_2",
        qualification: "MBBS, DNB",
        specialization: "Dermatologist",
        experience: 8,
        rating: 4.7,
        contactNumber: "1234567891",
        email: "janesmith@example.com",
        timings: "9:00 AM - 3:00 PM",
        profileImage:
            "https://th.bing.com/th/id/OIP.aYcY3Q5FHAdALAEGuzFJYgHaHa?w=500&h=500&rs=1&pid=ImgDetMain",
        clinicAddress: "456 Skin Street, Care Town",
        aboutUs: "Specialist in skincare treatments and consultations.",
        price: "800",
        role: "Doctor",
        patientNo: 150,
      ),
      DoctorModel(
        id: "doc003",
        name: "Dr. Richard Lee",
        userName: "richardlee",
        hashPassword: "hashed_password_3",
        qualification: "MBBS, MS",
        specialization: "Orthopedic Surgeon",
        experience: 12,
        rating: 4.9,
        contactNumber: "1234567892",
        email: "richardlee@example.com",
        timings: "11:00 AM - 5:00 PM",
        profileImage:
            "https://th.bing.com/th/id/OIP.Lxe6u-CdYdvFNH5j6z3TZwAAAA?w=384&h=536&rs=1&pid=ImgDetMain",
        clinicAddress: "789 Bone Ave, Flex City",
        aboutUs:
            "Orthopedic surgeon specializing in joint replacement and sports injuries.",
        price: "1200",
        role: "Doctor",
        patientNo: 200,
      ),
      DoctorModel(
        id: "doc004",
        name: "Dr. Emily Davis",
        userName: "emilydavis",
        hashPassword: "hashed_password_4",
        qualification: "MBBS, MD (Pediatrics)",
        specialization: "Pediatrician",
        experience: 7,
        rating: 4.6,
        contactNumber: "1234567893",
        email: "emilydavis@example.com",
        timings: "9:30 AM - 2:30 PM",
        profileImage:
            "https://th.bing.com/th/id/OIP.4ERAZSYnoe5bhAxMyOVxSQHaJY?w=808&h=1024&rs=1&pid=ImgDetMain",
        clinicAddress: "12 Child Care Rd, Happy Town",
        aboutUs:
            "Caring pediatrician dedicated to child health and well-being.",
        price: "700",
        role: "Doctor",
        patientNo: 130,
      ),
      DoctorModel(
        id: "doc005",
        name: "Dr. Michael Brown",
        userName: "michaelbrown",
        hashPassword: "hashed_password_5",
        qualification: "MBBS, MD (Neurology)",
        specialization: "Neurologist",
        experience: 15,
        rating: 4.8,
        contactNumber: "1234567894",
        email: "michaelbrown@example.com",
        timings: "10:00 AM - 3:00 PM",
        profileImage:
            "https://www.archerreview.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fmedical.030db868.png&w=384&q=75",
        clinicAddress: "34 Neuro St, Brain City",
        aboutUs:
            "Expert neurologist with 15 years of experience in brain disorders.",
        price: "1500",
        role: "Doctor",
        patientNo: 250,
      ),
      DoctorModel(
        id: "doc006",
        name: "Dr. Sophia Wilson",
        userName: "sophiawilson",
        hashPassword: "hashed_password_6",
        qualification: "MBBS, DGO",
        specialization: "Gynecologist",
        experience: 10,
        rating: 4.7,
        contactNumber: "1234567895",
        email: "sophiawilson@example.com",
        timings: "10:30 AM - 5:30 PM",
        profileImage:
            "https://hghinjections.com/wp-content/uploads/progesterone-therapy-for-hair-loss.jpg",
        clinicAddress: "56 Women's Health Blvd, Care Town",
        aboutUs: "Gynecologist dedicated to women's health and wellness.",
        price: "1100",
        role: "Doctor",
        patientNo: 180,
      ),
      DoctorModel(
        id: "doc007",
        name: "Dr. Daniel Carter",
        userName: "danielcarter",
        hashPassword: "hashed_password_7",
        qualification: "MBBS, MD (Psychiatry)",
        specialization: "Psychiatrist",
        experience: 9,
        rating: 4.9,
        contactNumber: "1234567896",
        email: "danielcarter@example.com",
        timings: "1:00 PM - 6:00 PM",
        profileImage:
            "https://th.bing.com/th/id/OIP.Hp7g_o7SHwA2MbAi2JH8MQAAAA?w=400&h=400&rs=1&pid=ImgDetMain",
        clinicAddress: "78 Mind St, Calm City",
        aboutUs:
            "Compassionate psychiatrist helping patients with mental health issues.",
        price: "900",
        role: "Doctor",
        patientNo: 170,
      ),
      DoctorModel(
        id: "doc008",
        name: "Dr. Olivia Martinez",
        userName: "oliviamartinez",
        hashPassword: "hashed_password_8",
        qualification: "MBBS, MD",
        specialization: "Endocrinologist",
        experience: 11,
        rating: 4.6,
        contactNumber: "1234567897",
        email: "oliviamartinez@example.com",
        timings: "10:00 AM - 4:00 PM",
        profileImage:
            "https://purepng.com/public/uploads/large/purepng.com-doctorsdoctorsdoctors-and-nursesa-qualified-practitioner-of-medicine-aclinicianmedical-practitionermale-doctor-142152685681255otq.png",
        clinicAddress: "90 Hormone Rd, Balance City",
        aboutUs: "Specialist in hormonal disorders and diabetes management.",
        price: "1000",
        role: "Doctor",
        patientNo: 160,
      ),
      DoctorModel(
        id: "doc009",
        name: "Dr. Benjamin Clark",
        userName: "benjaminclark",
        hashPassword: "hashed_password_9",
        qualification: "MBBS, MS (Surgery)",
        specialization: "General Surgeon",
        experience: 13,
        rating: 4.8,
        contactNumber: "1234567898",
        email: "benjaminclark@example.com",
        timings: "8:00 AM - 2:00 PM",
        profileImage:
            "https://th.bing.com/th/id/OIP.4htJbrly9qr47sFQoj5FhgAAAA?w=474&h=307&rs=1&pid=ImgDetMain",
        clinicAddress: "123 Surgery Blvd, Care Town",
        aboutUs:
            "Highly experienced surgeon specializing in general and emergency surgeries.",
        price: "1300",
        role: "Doctor",
        patientNo: 220,
      ),
      DoctorModel(
        id: "doc010",
        name: "Dr. Isabella Adams",
        userName: "isabellaadams",
        hashPassword: "hashed_password_10",
        qualification: "MBBS, MD (Oncology)",
        specialization: "Oncologist",
        experience: 14,
        rating: 4.9,
        contactNumber: "1234567899",
        email: "isabellaadams@example.com",
        timings: "11:00 AM - 5:00 PM",
        profileImage:
            "https://www.humanitas.net/content/uploads/2017/10/doctors.jpg",
        clinicAddress: "456 Cancer Care Rd, Hope City",
        aboutUs: "Leading oncologist with expertise in cancer treatments.",
        price: "1800",
        role: "Doctor",
        patientNo: 300,
      ),
    ];

    for (var doctor in demoDoctors) {
      await addDoctorAsync(doctor);
    }
  }

  Stream<List<DoctorModel>> getDoctors() {
    return db.collection('doctors').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).toList());
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading(true);
      var snapshot = await db.collection('doctors').get();
      doctors.value =
          snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch doctors: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchDoctor(String? searchValue) async {
    try {
      if (searchValue == null || searchValue.isEmpty) {
        var snapshot = await db.collection('doctors').get();
        doctors.value = snapshot.docs
            .map((doc) => DoctorModel.fromJson(doc.data()))
            .toList();
        return;
      }

      isLoading(true);

      List<DoctorModel> doctorsList = await db
          .collection('doctors')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DoctorModel.fromJson(doc.data()))
              .toList())
          .first;

      doctors.value = doctorsList
          .where((doctor) =>
              doctor.name!.toLowerCase().contains(searchValue.toLowerCase()) ||
              doctor.specialization!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to search doctors: $e");
    } finally {
      isLoading(false);
    }
  }
}
