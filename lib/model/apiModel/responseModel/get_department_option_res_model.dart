class GetDepartmentOptionResModel {
  GetDepartmentOptionResModel({
    this.data,
    this.status,
  });

  GetDepartmentOptionResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    }
    status = json['status'];
  }

  List<Data>? data = [];
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
    this.id,
    this.name,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
