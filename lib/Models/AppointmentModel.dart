
class AppointmentModel {
  String? id;
  String? doctorId;
  String? userId;
  String? date;
  String? time;
  String? amount;
  String? doctorName;
  String? doctorSpecialization;
  String? doctorProfileImage;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? userProfileImage;

  String? treatmentDetails;
  String? treatmentDate;
  String? treatmentImage;

  AppointmentModel({this.id, this.doctorId, this.userId, this.date, this.time, this.amount, this.doctorName, this.doctorSpecialization, this.doctorProfileImage, this.status, this.createdAt, this.updatedAt, this.userName, this.userProfileImage, this.treatmentDetails, this.treatmentDate, this.treatmentImage});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["doctorId"] is String) {
      doctorId = json["doctorId"];
    }
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["time"] is String) {
      time = json["time"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
    if(json["doctorName"] is String) {
      doctorName = json["doctorName"];
    }
    if(json["doctorSpecialization"] is String) {
      doctorSpecialization = json["doctorSpecialization"];
    }
    if(json["doctorProfileImage"] is String) {
      doctorProfileImage = json["doctorProfileImage"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["userName"] is String) {
      userName = json["userName"];
    }
    if(json["userProfileImage"] is String) {
      userProfileImage = json["userProfileImage"];
    }
    if(json["treatmentDetails"] is String) {
      treatmentDetails = json["treatmentDetails"];
    }
    if(json["treatmentDate"] is String) {
      treatmentDate = json["treatmentDate"];
    }
    if(json["treatmentImage"] is String) {
      treatmentImage = json["treatmentImage"];
    }
  }

  static List<AppointmentModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AppointmentModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["doctorId"] = doctorId;
    _data["userId"] = userId;
    _data["date"] = date;
    _data["time"] = time;
    _data["amount"] = amount;
    _data["doctorName"] = doctorName;
    _data["doctorSpecialization"] = doctorSpecialization;
    _data["doctorProfileImage"] = doctorProfileImage;
    _data["status"] = status;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["userName"] = userName;
    _data["userProfileImage"] = userProfileImage;
    _data["treatmentDetails"] = treatmentDetails;
    _data["treatmentDate"] = treatmentDate;
    _data["treatmentImage"] = treatmentImage;
    return _data;
  }
}