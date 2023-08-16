class UpdateHomeworkReqModel {
  UpdateHomeworkReqModel({
    this.homeworkId,
    this.teacherId,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.hDate,
    this.completeDate,
    this.title,
    this.description,
    this.status,
    this.attachment,
  });

  UpdateHomeworkReqModel.fromJson(dynamic json) {
    homeworkId = json['homework_id'];
    teacherId = json['teacher_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    hDate = json['h_date'];
    completeDate = json['complete_date'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    attachment = json['attachment'];
  }

  String? homeworkId;
  String? teacherId;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? hDate;
  String? completeDate;
  String? title;
  String? description;
  String? status;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = "updateHomework";
    map['homework_id'] = homeworkId;
    map['teacher_id'] = teacherId;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['subject_id'] = subjectId;
    map['h_date'] = hDate;
    map['complete_date'] = completeDate;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['attachment'] = attachment;
    return map;
  }
}
