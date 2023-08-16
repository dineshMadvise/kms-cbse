class GetLessonPlanListResModel {
  GetLessonPlanListResModel({
    this.data,
    this.status,
  });

  GetLessonPlanListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(LessonPlanData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }
  List<LessonPlanData>? data = [];
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

class LessonPlanData {
  LessonPlanData({
    this.teacherName,
    this.subject,
    this.startDate,
    this.endDate,
    this.progress,
    this.status,
    this.file,
    this.id
  });

  LessonPlanData.fromJson(dynamic json) {
    teacherName = json['teacher_name'];
    subject = json['subject'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    progress = json['progress'];
    status = json['status'];
    file = json['file'];
    id = json['id'];
  }
  String? teacherName;
  String? subject;
  String? startDate;
  String? endDate;
  String? progress;
  String? status;
  String? file;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['teacher_name'] = teacherName;
    map['subject'] = subject;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['progress'] = progress;
    map['status'] = status;
    map['file'] = file;
    map['id']=id;
    return map;
  }
}
