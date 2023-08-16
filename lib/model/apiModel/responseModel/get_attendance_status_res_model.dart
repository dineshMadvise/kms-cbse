class GetAttendanceStatusResModel {
  GetAttendanceStatusResModel({
    this.data,
    this.status,});

  GetAttendanceStatusResModel.fromJson(dynamic json) {
    data = json['DATA'] != null ? json['DATA'].cast<String>() : [];
    status = json['status'];
  }
  List<String>? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DATA'] = data;
    map['status'] = status;
    return map;
  }

}