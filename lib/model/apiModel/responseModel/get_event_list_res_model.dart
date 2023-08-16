class GetEventListResModel {
  GetEventListResModel({this.data, this.status, this.msg});

  GetEventListResModel.fromJson(dynamic json) {
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
  List<Data>? data = [];
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

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.venue,
    this.startDate,
    this.startTime,
    this.endTime,
    this.attendees,
    this.teacherId,
    this.createdOn,
    this.updatedOn,
    this.eventDayDate,
    this.img,
    this.studentList,
    this.moreStudentCnt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    venue = json['venue'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    attendees = json['attendees'];
    teacherId = json['teacher_id'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    eventDayDate = json['event_day_date'];
    img = json['img'];
    studentList =
        json['student_list'] != null ? json['student_list'].cast<String>() : [];
    moreStudentCnt = json['more_student_cnt'] ?? 0;
  }
  String? id;
  String? title;
  String? description;
  String? venue;
  String? startDate;
  String? startTime;
  String? endTime;
  String? attendees;
  String? teacherId;
  String? createdOn;
  String? updatedOn;
  String? eventDayDate;
  String? img;
  List<String>? studentList = [];
  int? moreStudentCnt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['venue'] = venue;
    map['start_date'] = startDate;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['attendees'] = attendees;
    map['teacher_id'] = teacherId;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['event_day_date'] = eventDayDate;
    map['img'] = img;
    map['student_list'] = studentList;
    map['more_student_cnt'] = moreStudentCnt;
    return map;
  }
}
