
class UserModel {
  String? id;
  String? name;
  String? userName;
  String? hashPassword;
  String? email;
  String? phoneNumber;
  String? profileImage;
  String? role;

  UserModel({this.id, this.name, this.userName, this.hashPassword, this.email, this.phoneNumber, this.profileImage, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["userName"] is String) {
      userName = json["userName"];
    }
    if(json["hashPassword"] is String) {
      hashPassword = json["hashPassword"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if(json["profileImage"] is String) {
      profileImage = json["profileImage"];
    }
    if(json["role"] is String) {
      role = json["role"];
    }
  }

  static List<UserModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["userName"] = userName;
    data["hashPassword"] = hashPassword;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    data["profileImage"] = profileImage;
    data["role"] = role;
    return data;
  }
}