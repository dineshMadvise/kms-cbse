class GetStudAttListResModel {
  GetStudAttListResModel({
    this.data,
    this.status,
  });

  GetStudAttListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(StudAttData.fromJson(v));
        });
      }
    }
    status = json['status'];
  }
  List<StudAttData>? data = [];
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

class StudAttData {
  StudAttData({
    this.id,
    this.name,
    this.attendance,
    this.leaveInfo
  });

  StudAttData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    attendance = json['attendance'];
    leaveInfo = json['leave_info'];
  }
  String? id;
  String? name;
  String? attendance;
  String? leaveInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['attendance'] = attendance;
    map['leave_info'] = leaveInfo;
    return map;
  }
}
