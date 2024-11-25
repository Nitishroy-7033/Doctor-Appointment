
class DocumentModel {
  String? id;
  String? imageUrl;
  String? title;

  DocumentModel({this.id, this.imageUrl, this.title});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
  }

  static List<DocumentModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DocumentModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["imageUrl"] = imageUrl;
    _data["title"] = title;
    return _data;
  }
}