
class NotificationModel {
  String? id;
  String? title;
  String? description;
  String? createdAt;

  NotificationModel({this.id, this.title, this.description, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  static List<NotificationModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(NotificationModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["createdAt"] = createdAt;
    return data;
  }
}