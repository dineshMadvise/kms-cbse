/// ALLOWED_MODULES : ["Homework","Online Class","Announcement","Student Attendance Listing","Add Student Attendance","Class Timetable","Exam Timetable","Exam Score","Leave Request","Leave Approve","Complaint","Events","Payslip","Claim"]
/// status : "OK"

class DashboardResModel {
  DashboardResModel({
    this.allowedmodules,
    this.status,
  });

  DashboardResModel.fromJson(dynamic json) {
    allowedmodules = json['ALLOWED_MODULES'] != null || json['status'] != "OK"
        ? json['ALLOWED_MODULES'].cast<String>()
        : [];
    status = json['status'];
  }

  List<String>? allowedmodules;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ALLOWED_MODULES'] = allowedmodules;
    map['status'] = status;
    return map;
  }
}
