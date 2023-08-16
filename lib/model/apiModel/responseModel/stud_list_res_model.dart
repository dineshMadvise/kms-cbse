/// DATA : [{"id":"2","name":"nuriah","class_name":"Grade 5","section_name":"A","profile":""},{"id":"4","name":"kiran","class_name":"Grade 1","section_name":"A","profile":""},{"id":"14","name":"keerthy","class_name":"Grade 5","section_name":"A","profile":""},{"id":"15","name":"divya","class_name":"Grade 5","section_name":"A","profile":""},{"id":"26","name":"Gavaya","class_name":"Grade 5","section_name":"B","profile":""}]
/// status : "OK"

class StudListResModel {
  StudListResModel({
    this.data,
    this.status,
  });

  StudListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(StudentData.fromJson(v));
        });
      }
    }
    status = json['status'];
  }

  List<StudentData>? data = [];
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

/// id : "2"
/// name : "nuriah"
/// class_name : "Grade 5"
/// section_name : "A"
/// profile : ""

class StudentData {
  StudentData({
    this.id,
    this.name,
    this.className,
    this.sectionName,
    this.profile,
    this.studentId,
  });

  StudentData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    className = json['class_name'];
    sectionName = json['section_name'];
    profile = json['profile'];
    studentId = json['student_id'];
  }

  String? id;
  String? name;
  String? className;
  String? sectionName;
  String? profile;
  String? studentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['class_name'] = className;
    map['section_name'] = sectionName;
    map['profile'] = profile;
    map['student_id'] = studentId;
    return map;
  }
}
