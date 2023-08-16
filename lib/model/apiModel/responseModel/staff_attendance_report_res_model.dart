class StaffAttendanceReportResModel {
  StaffAttendanceReportResModel({
    this.data,
    this.status,
  });

  StaffAttendanceReportResModel.fromJson(dynamic json) {
    data = json['DATA'] != null ? Data.fromJson(json['DATA']) : null;
    status = json['status'];
  }
  Data? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.teacher,
    this.staff,
  });

  Data.fromJson(dynamic json) {
    teacher =
        json['TEACHER'] != null ? Teacher.fromJson(json['TEACHER']) : null;
    staff = json['STAFF'] != null ? Staff.fromJson(json['STAFF']) : null;
  }
  Teacher? teacher;
  Staff? staff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teacher != null) {
      map['TEACHER'] = teacher?.toJson();
    }
    if (staff != null) {
      map['STAFF'] = staff?.toJson();
    }
    return map;
  }
}

class Staff {
  Staff({
    this.totalstaff,
    this.totalpresent,
    this.totalabsent,
    this.totalnotmarked,
  });

  Staff.fromJson(dynamic json) {
    totalstaff = json['TOTAL_STAFF'];
    totalpresent = json['TOTAL_PRESENT'];
    totalabsent = json['TOTAL_ABSENT'];
    totalnotmarked = json['TOTAL_NOT_MARKED'];
  }
  num? totalstaff;
  num? totalpresent;
  num? totalabsent;
  num? totalnotmarked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TOTAL_STAFF'] = totalstaff;
    map['TOTAL_PRESENT'] = totalpresent;
    map['TOTAL_ABSENT'] = totalabsent;
    map['TOTAL_NOT_MARKED'] = totalnotmarked;
    return map;
  }
}

class Teacher {
  Teacher({
    this.totalteacher,
    this.totalpresent,
    this.totalabsent,
    this.totalnotmarked,
  });

  Teacher.fromJson(dynamic json) {
    totalteacher = json['TOTAL_TEACHER'];
    totalpresent = json['TOTAL_PRESENT'];
    totalabsent = json['TOTAL_ABSENT'];
    totalnotmarked = json['TOTAL_NOT_MARKED'];
  }
  num? totalteacher;
  num? totalpresent;
  num? totalabsent;
  num? totalnotmarked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TOTAL_TEACHER'] = totalteacher;
    map['TOTAL_PRESENT'] = totalpresent;
    map['TOTAL_ABSENT'] = totalabsent;
    map['TOTAL_NOT_MARKED'] = totalnotmarked;
    return map;
  }
}
