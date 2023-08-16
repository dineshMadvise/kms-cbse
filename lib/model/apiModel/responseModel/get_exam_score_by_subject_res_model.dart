class GetExamScoreBySubjectResModel {
  GetExamScoreBySubjectResModel(
      {this.ediatble, this.data, this.status, this.msg});

  GetExamScoreBySubjectResModel.fromJson(dynamic json) {
    ediatble = json['Ediatble'];
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(Data.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  String? ediatble;
  List<Data>? data = [];
  String? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ediatble'] = ediatble;
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.studentId,
    this.studentName,
    this.mark,
  });

  Data.fromJson(dynamic json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    mark = json['mark'];
  }

  String? studentId;
  String? studentName;
  String? mark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['student_id'] = studentId;
    map['student_name'] = studentName;
    map['mark'] = mark;
    return map;
  }
}
