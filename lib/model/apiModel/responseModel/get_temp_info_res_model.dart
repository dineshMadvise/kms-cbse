class GetTempIdResModel {
  GetTempIdResModel({
      this.data, 
      this.status,});

  GetTempIdResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Data>? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

class Data {
  Data({
      this.title, 
      this.description,});

  Data.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }
  String? title;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    return map;
  }

}