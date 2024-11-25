class DoctorModel {
  String? id;
  String? name;
  String? userName;
  String? hashPassword;
  String? qualification;
  String? specialization;
  int? experience;
  double? rating;
  String? contactNumber;
  String? email;
  String? timings;
  String? profileImage;
  String? clinicAddress;
  String? aboutUs;
  String? price;
  String? role;
  int? patientNo;

  DoctorModel(
      {this.id,
      this.name,
      this.userName,
      this.hashPassword,
      this.qualification,
      this.specialization,
      this.experience,
      this.rating,
      this.contactNumber,
      this.email,
      this.timings,
      this.profileImage,
      this.clinicAddress,
      this.aboutUs,
      this.price,
      this.role,
      this.patientNo});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["userName"] is String) {
      userName = json["userName"];
    }
    if (json["hashPassword"] is String) {
      hashPassword = json["hashPassword"];
    }
    if (json["qualification"] is String) {
      qualification = json["qualification"];
    }
    if (json["specialization"] is String) {
      specialization = json["specialization"];
    }
    if (json["experience"] is int) {
      experience = json["experience"];
    }
    if (json["rating"] is double) {
      rating = json["rating"];
    }
    if (json["contactNumber"] is String) {
      contactNumber = json["contactNumber"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["timings"] is String) {
      timings = json["timings"];
    }
    if (json["profileImage"] is String) {
      profileImage = json["profileImage"];
    }
    if (json["clinicAddress"] is String) {
      clinicAddress = json["clinicAddress"];
    }
    if (json["aboutUs"] is String) {
      aboutUs = json["aboutUs"];
    }
    if (json["price"] is String) {
      price = json["price"];
    }
    if (json["role"] is String) {
      role = json["role"];
    }
    if (json["patientNo"] is int) {
      patientNo = json["patientNo"];
    }
  }

  static List<DoctorModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DoctorModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["userName"] = userName;
    data["hashPassword"] = hashPassword;
    data["qualification"] = qualification;
    data["specialization"] = specialization;
    data["experience"] = experience;
    data["rating"] = rating;
    data["contactNumber"] = contactNumber;
    data["email"] = email;
    data["timings"] = timings;
    data["profileImage"] = profileImage;
    data["clinicAddress"] = clinicAddress;
    data["aboutUs"] = aboutUs;
    data["price"] = price;
    data["role"] = role;
    data["patientNo"] = patientNo;
      return data;
  }
}
