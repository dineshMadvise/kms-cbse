class GetTeacherAttendanceListResModel {
  GetTeacherAttendanceListResModel({this.data, this.status, this.msg});

  GetTeacherAttendanceListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(TeacherData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<TeacherData>? data = [];
  String? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class TeacherData {
  TeacherData({
    this.id,
    this.name,
    this.attendance,
    this.leaveInfo
  });

  TeacherData.fromJson(dynamic json) {
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
