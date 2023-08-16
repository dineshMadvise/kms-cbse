class GetOnlineClassListResModel {
  GetOnlineClassListResModel({this.data, this.status, this.msg});

  GetOnlineClassListResModel.fromJson(dynamic json) {
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
    this.academicYearId,
    this.dayNo,
    this.orderNo,
    this.joinLink,
    this.languageId,
    this.joinLink2,
    this.joinId2,
    this.joinPassword2,
    this.joinId,
    this.joinPassword,
    this.classId,
    this.sectionId,
    this.usedFlag,
    this.deletedFlag,
    this.createdBy,
    this.updatedBy,
    this.createdUserType,
    this.updatedUserType,
    this.createdOn,
    this.updatedOn,
    this.status,
    this.languageName,
    this.className,
    this.sectionName,
    this.cDate,
    this.dateDay,
    this.startTime,
    this.endTime,
    this.teacherName,
    this.subjectName,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    academicYearId = json['academic_year_id'];
    dayNo = json['day_no'];
    orderNo = json['order_no'];
    joinLink = json['join_link'] == "" ? null : json['join_link'];
    languageId = json['language_id'];
    joinLink2 = json['join_link2'] == '' ? null : json['join_link2'];
    joinId2 = json['join_id2'];
    joinPassword2 = json['join_password2'];
    joinId = json['join_id'];
    joinPassword = json['join_password'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    usedFlag = json['used_flag'];
    deletedFlag = json['deleted_flag'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdUserType = json['created_user_type'];
    updatedUserType = json['updated_user_type'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    status = json['status'];
    languageName = json['language_name'];
    className = json['class_name'];
    sectionName = json['section_name'];
    cDate = json['c_date'];
    dateDay = json['date_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    teacherName = json['teacher_name'];
    subjectName = json['subject_name'];
  }
  String? id;
  String? academicYearId;
  String? dayNo;
  String? orderNo;
  String? joinLink;
  String? languageId;
  String? joinLink2;
  String? joinId2;
  String? joinPassword2;
  String? joinId;
  String? joinPassword;
  String? classId;
  String? sectionId;
  String? usedFlag;
  String? deletedFlag;
  String? createdBy;
  String? updatedBy;
  String? createdUserType;
  String? updatedUserType;
  String? createdOn;
  String? updatedOn;
  String? status;
  dynamic languageName;
  String? className;
  String? sectionName;
  String? cDate;
  String? dateDay;
  String? startTime;
  String? endTime;
  String? teacherName;
  String? subjectName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['academic_year_id'] = academicYearId;
    map['day_no'] = dayNo;
    map['order_no'] = orderNo;
    map['join_link'] = joinLink;
    map['language_id'] = languageId;
    map['join_link2'] = joinLink2;
    map['join_id2'] = joinId2;
    map['join_password2'] = joinPassword2;
    map['join_id'] = joinId;
    map['join_password'] = joinPassword;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['used_flag'] = usedFlag;
    map['deleted_flag'] = deletedFlag;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_user_type'] = createdUserType;
    map['updated_user_type'] = updatedUserType;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['status'] = status;
    map['language_name'] = languageName;
    map['class_name'] = className;
    map['section_name'] = sectionName;
    map['c_date'] = cDate;
    map['date_day'] = dateDay;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['teacher_name'] = teacherName;
    map['subject_name'] = subjectName;
    return map;
  }
}
