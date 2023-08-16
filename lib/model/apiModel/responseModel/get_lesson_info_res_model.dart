class GetLessonInfoResModel {
  GetLessonInfoResModel({
      this.data, 
      this.status,});

  GetLessonInfoResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Data>? data;
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

class Data {
  Data({
      this.id, 
      this.classId, 
      this.subjectId, 
      this.startDate, 
      this.endDate, 
      this.objectives, 
      this.aids, 
      this.assignment, 
      this.evaluation,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    classId = json['class_id'];
    subjectId = json['subject_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    objectives = json['objectives'];
    aids = json['aids'];
    assignment = json['assignment'];
    evaluation = json['evaluation'];
  }
  String? id;
  String? classId;
  String? subjectId;
  String? startDate;
  String? endDate;
  String? objectives;
  String? aids;
  String? assignment;
  String? evaluation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['class_id'] = classId;
    map['subject_id'] = subjectId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['objectives'] = objectives;
    map['aids'] = aids;
    map['assignment'] = assignment;
    map['evaluation'] = evaluation;
    return map;
  }

}