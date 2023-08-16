class GetNotificationListResModel {
  GetNotificationListResModel({
    this.data,
    this.status,
  });

  GetNotificationListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    }
    status = json['status'];
  }

  List<Data>? data = [];
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
    this.userType,
    this.userId,
    this.mobileToken,
    this.moduleName,
    this.recordId,
    this.title,
    this.description,
    this.createdOn,
    this.sentFlag,
    this.sentTime,
    this.readFlag,
    this.createdBy,
    this.createdByType,
    this.shortTitle,
    this.aDate,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userType = json['user_type'];
    userId = json['user_id'];
    mobileToken = json['mobile_token'];
    moduleName = json['module_name'];
    recordId = json['record_id'];
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
    sentFlag = json['sent_flag'];
    sentTime = json['sent_time'];
    readFlag = json['read_flag'];
    createdBy = json['created_by'];
    createdByType = json['created_by_type'];
    shortTitle = json['short_title'];
    aDate = json['a_date'];
  }

  String? id;
  String? userType;
  String? userId;
  String? mobileToken;
  String? moduleName;
  String? recordId;
  String? title;
  String? description;
  String? createdOn;
  String? sentFlag;
  String? sentTime;
  String? readFlag;
  String? createdBy;
  String? createdByType;
  String? shortTitle;
  String? aDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_type'] = userType;
    map['user_id'] = userId;
    map['mobile_token'] = mobileToken;
    map['module_name'] = moduleName;
    map['record_id'] = recordId;
    map['title'] = title;
    map['description'] = description;
    map['created_on'] = createdOn;
    map['sent_flag'] = sentFlag;
    map['sent_time'] = sentTime;
    map['read_flag'] = readFlag;
    map['created_by'] = createdBy;
    map['created_by_type'] = createdByType;
    map['short_title'] = shortTitle;
    map['a_date'] = aDate;
    return map;
  }
}
