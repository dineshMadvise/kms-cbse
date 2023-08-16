// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class GetAttendanceResModel {
  List<DATA>? dATA = [];
  String? status;
  String? msg;

  GetAttendanceResModel({this.dATA, this.status});

  GetAttendanceResModel.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            dATA?.add(DATA.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dATA != null) {
      data['DATA'] = this.dATA!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class DATA {
  int? workingDays;
  List<Legends>? legends;
  List<AttendanceInfo>? attendanceInfo;

  DATA({this.workingDays, this.legends, this.attendanceInfo});

  DATA.fromJson(Map<String, dynamic> json) {
    workingDays = json['working_days'];
    if (json['legends'] != null) {
      legends = <Legends>[];
      json['legends'].forEach((v) {
        legends!.add(new Legends.fromJson(v));
      });
    }
    if (json['attendance_info'] != null) {
      attendanceInfo = <AttendanceInfo>[];
      json['attendance_info'].forEach((v) {
        attendanceInfo!.add(new AttendanceInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_days'] = this.workingDays;
    if (this.legends != null) {
      data['legends'] = this.legends!.map((v) => v.toJson()).toList();
    }
    if (this.attendanceInfo != null) {
      data['attendance_info'] =
          this.attendanceInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Legends {
  String? name;
  String? colorCode;

  Legends({this.name, this.colorCode});

  Legends.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color_code'] = this.colorCode;
    return data;
  }
}

class AttendanceInfo {
  String? runningDate;
  String? status;
  String? description;
  String? colorCode;

  AttendanceInfo(
      {this.runningDate, this.status, this.description, this.colorCode});

  AttendanceInfo.fromJson(Map<String, dynamic> json) {
    runningDate = json['running_date'];
    status = json['status'];
    description = json['description'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['running_date'] = this.runningDate;
    data['status'] = this.status;
    data['description'] = this.description;
    data['color_code'] = this.colorCode;
    return data;
  }
}

// class GetAttendanceResModel {
//   GetAttendanceResModel({this.data, this.status, this.msg});
//
//   GetAttendanceResModel.fromJson(dynamic json) {
//     if (json['DATA'] != null) {
//       if (json['DATA'] is List<dynamic>) {
//         if ((json['DATA'] as List<dynamic>).isEmpty) {
//           msg = 'No record found';
//         } else {
//           json['DATA'].forEach((v) {
//             data?.add(Data.fromJson(v));
//           });
//         }
//       } else {
//         msg = json['DATA'];
//       }
//     }
//     status = json['status'];
//   }
//   List<Data>? data = [];
//   String? status;
//   String? msg;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (data != null) {
//       map['DATA'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['status'] = status;
//     return map;
//   }
// }
//
// class Data {
//   Data({
//     this.monthName,
//     this.workingDays,
//     this.attendanceInfo,
//   });
//
//   Data.fromJson(dynamic json) {
//     monthName = json['month_name'];
//     workingDays = json['working_days'];
//     if (json['attendance_info'] != null) {
//       attendanceInfo = [];
//       json['attendance_info'].forEach((v) {
//         attendanceInfo?.add(AttendanceInfo.fromJson(v));
//       });
//     }
//   }
//   String? monthName;
//   int? workingDays;
//   List<AttendanceInfo>? attendanceInfo;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['month_name'] = monthName;
//     map['working_days'] = workingDays;
//     if (attendanceInfo != null) {
//       map['attendance_info'] = attendanceInfo?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class AttendanceInfo {
//   AttendanceInfo({
//     this.runningDate,
//     this.status,
//   });
//
//   AttendanceInfo.fromJson(dynamic json) {
//     runningDate = json['running_date'];
//     status = json['status'];
//   }
//   String? runningDate;
//   String? status;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['running_date'] = runningDate;
//     map['status'] = status;
//     return map;
//   }
// }
