
class ReviewModel {
  String? id;
  String? doctorId;
  String? review;
  String? userId;
  String? createdAt;
  String? userName;
  String? userImage;

  ReviewModel({this.id, this. doctorId, this.review, this.userId, this.createdAt, this.userName, this.userImage});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];

      if(json["doctorId"] is String) {
      doctorId = json["doctorId"];
    }
    if(json["review"] is String) {
      review = json["review"];
    }
    if(json["userId"] is String) {
      userId = json["userId"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["userName"] is String) {
      userName = json["userName"];
    }
    if(json["userImage"] is String) {
      userImage = json["userImage"];
    }
  }

  static List<ReviewModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ReviewModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["doctorId"] = doctorId;
    _data["review"] = review;
    _data["userId"] = userId;
    _data["createdAt"] = createdAt;
    _data["userName"] = userName;
    _data["userImage"] = userImage;
    return _data;
  }
}