class LocalProfile {
  String? id;
  String? name;
  String? userName;
  String? hashPassword;
  String? email;
  String? phoneNumber;
  String? profileImage;
  String? role;
  String? qualification;
  String? specialization;
  int? experience;
  double? rating;
  String? contactNumber;
  String? timings;
  String? clinicAddress;
  String? aboutUs;
  String? price;
  int? patientNo;

  LocalProfile({
    this.id,
    this.name,
    this.userName,
    this.hashPassword,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.role,
    this.qualification,
    this.specialization,
    this.experience,
    this.rating,
    this.contactNumber,
    this.timings,
    this.clinicAddress,
    this.aboutUs,
    this.price,
    this.patientNo,
  });

  // Convert a LocalProfile to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'hashPassword': hashPassword,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'role': role,
      'qualification': qualification,
      'specialization': specialization,
      'experience': experience,
      'rating': rating,
      'contactNumber': contactNumber,
      'timings': timings,
      'clinicAddress': clinicAddress,
      'aboutUs': aboutUs,
      'price': price,
      'patientNo': patientNo,
    };
  }

  // Create a LocalProfile from a JSON map.
  factory LocalProfile.fromJson(Map<String, dynamic> json) {
    return LocalProfile(
      id: json['id'],
      name: json['name'],
      userName: json['userName'],
      hashPassword: json['hashPassword'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      role: json['role'],
      qualification: json['qualification'],
      specialization: json['specialization'],
      experience: json['experience'],
      rating: (json['rating'] != null) ? json['rating'].toDouble() : null,
      contactNumber: json['contactNumber'],
      timings: json['timings'],
      clinicAddress: json['clinicAddress'],
      aboutUs: json['aboutUs'],
      price: json['price'],
      patientNo: json['patientNo'],
    );
  }
}
