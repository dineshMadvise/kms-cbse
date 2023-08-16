class GetAnnounceListResModel {
  GetAnnounceListResModel({this.data, this.status, this.msg});

  GetAnnounceListResModel.fromJson(dynamic json) {
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
    this.title,
    this.description,
    this.aDate,
    this.attachment,
    this.notificationType,
    this.publishTo,
    this.classId,
    this.sectionId,
    this.studentId,
    this.status,
    this.usedFlag,
    this.deletedFlag,
    this.createdBy,
    this.updatedBy,
    this.createdUserType,
    this.updatedUserType,
    this.createdOn,
    this.updatedOn,
    this.sentFlag,
    this.sentCount,
    this.readCount,
    this.remarkCount,
    this.notihistory,
    this.sent,
    this.read,
    this.shortTitle,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    academicYearId = json['academic_year_id'];
    title = json['title'];
    description = json['description'];
    aDate = json['a_date'];
    attachment = json['attachment'] ?? '';
    notificationType = json['notification_type'];
    publishTo = json['publish_to'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    studentId = json['student_id'];
    status = json['status'];
    usedFlag = json['used_flag'];
    deletedFlag = json['deleted_flag'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdUserType = json['created_user_type'];
    updatedUserType = json['updated_user_type'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    sentFlag = json['sent_flag'];
    sentCount = json['sent_count'];
    readCount = json['read_count'];
    remarkCount = json['remark_count'];
    if (json['notihistory'] != null) {
      notihistory = [];
      json['notihistory'].forEach((v) {
        notihistory?.add(Notihistory.fromJson(v));
      });
    }
    sent = json['sent'];
    read = json['read'];
    shortTitle = json['short_title'];
  }

  String? id;
  String? academicYearId;
  String? title;
  String? description;
  String? aDate;
  String? attachment;
  String? notificationType;
  String? publishTo;
  String? classId;
  String? sectionId;
  String? studentId;
  String? status;
  String? usedFlag;
  String? deletedFlag;
  String? createdBy;
  String? updatedBy;
  String? createdUserType;
  String? updatedUserType;
  String? createdOn;
  String? updatedOn;
  String? sentFlag;
  String? sentCount;
  String? readCount;
  int? remarkCount;
  List<Notihistory>? notihistory = [];
  int? sent;
  int? read;
  String? shortTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['academic_year_id'] = academicYearId;
    map['title'] = title;
    map['description'] = description;
    map['a_date'] = aDate;
    map['attachment'] = attachment;
    map['notification_type'] = notificationType;
    map['publish_to'] = publishTo;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['student_id'] = studentId;
    map['status'] = status;
    map['used_flag'] = usedFlag;
    map['deleted_flag'] = deletedFlag;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_user_type'] = createdUserType;
    map['updated_user_type'] = updatedUserType;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['sent_flag'] = sentFlag;
    map['sent_count'] = sentCount;
    map['read_count'] = readCount;
    map['remark_count'] = remarkCount;
    if (notihistory != null) {
      map['notihistory'] = notihistory?.map((v) => v.toJson()).toList();
    }
    map['sent'] = sent;
    map['read'] = read;
    map['short_title'] = shortTitle;
    return map;
  }
}

class Notihistory {
  Notihistory({
    this.readdate,
    this.userType,
    this.name,
    this.remark,
  });

  Notihistory.fromJson(dynamic json) {
    readdate = json['readdate'];
    userType = json['user_type'];
    name = json['name'];
    remark = json['remark'];
  }

  dynamic readdate;
  String? userType;
  String? name;
  String? remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['readdate'] = readdate;
    map['user_type'] = userType;
    map['name'] = name;
    map['remark'] = remark;
    return map;
  }
}
