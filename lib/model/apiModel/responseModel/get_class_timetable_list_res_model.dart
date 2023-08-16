import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

/// DATA : [{"day":"Monday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"EVS","teacher":"Divya R"},{"timeduration":"10.10-10.40","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"Hindi","teacher":"Divya R"},{"timeduration":"11.30-12.30","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"Hindi","teacher":"Deepika Nagapandian"},{"timeduration":"14.00-14.40","subject":"Hindi","teacher":"Divya R"}]},{"day":"Tuesday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"10.10-10.40","subject":"EVS","teacher":"Divya R"},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"11.30-12.30","subject":"TELGU","teacher":"Deepika Nagapandian"},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"EVS","teacher":"Divya R"},{"timeduration":"14.00-14.40","subject":"English","teacher":"Thara kesavan"}]},{"day":"Wednesday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"TELGU","teacher":"Deepika Nagapandian"},{"timeduration":"10.10-10.40","subject":"English","teacher":"Thara kesavan"},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"English","teacher":"Thara kesavan"},{"timeduration":"11.30-12.30","subject":"English","teacher":"Mahendran ."},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"14.00-14.40","subject":"Hindi","teacher":"Deepika Nagapandian"}]},{"day":"Thursday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"EVS","teacher":"Divya R"},{"timeduration":"10.10-10.40","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"11.30-12.30","subject":"TELGU","teacher":"Deepika Nagapandian"},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"Hindi","teacher":"Divya R"},{"timeduration":"14.00-14.40","subject":"Computer Science","teacher":"Thara kesavan"}]},{"day":"Friday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"EVS","teacher":"Mahendran ."},{"timeduration":"10.10-10.40","subject":"Hindi","teacher":"Divya R"},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"11.30-12.30","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"EVS","teacher":"Mahendran ."},{"timeduration":"14.00-14.40","subject":"English","teacher":"Thara kesavan"}]},{"day":"Saturday","time":"09:00 AM - 02:40 PM","periodlist":[{"timeduration":"09.00-10.01","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"10.10-10.40","subject":"Mathematics","teacher":"Mahendran ."},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"TELGU","teacher":"Deepika Nagapandian"},{"timeduration":"11.30-12.30","subject":"Hindi","teacher":"Deepika Nagapandian"},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"English","teacher":"Thara kesavan"},{"timeduration":"14.00-14.40","subject":"EVS","teacher":"Mahendran ."}]}]
/// status : "OK"

class GetClassTimetableListResModel {
  GetClassTimetableListResModel({this.data, this.status, this.msg});

  GetClassTimetableListResModel.fromJson(dynamic json) {
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

/// day : "Monday"
/// time : "09:00 AM - 02:40 PM"
/// periodlist : [{"timeduration":"09.00-10.01","subject":"EVS","teacher":"Divya R"},{"timeduration":"10.10-10.40","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"10.40-10.50","teacher":"Break"},{"timeduration":"10.50-11.30","subject":"Hindi","teacher":"Divya R"},{"timeduration":"11.30-12.30","subject":"Computer Science","teacher":"Thara kesavan"},{"timeduration":"12.30-13.10","teacher":"Break"},{"timeduration":"13.10-14.00","subject":"Hindi","teacher":"Deepika Nagapandian"},{"timeduration":"14.00-14.40","subject":"Hindi","teacher":"Divya R"}]

class Data {
  Data({
    this.day,
    this.time,
    this.periodlist,
  });

  Data.fromJson(dynamic json) {
    day = json['day'];
    time = json['time'];
    if (json['periodlist'] != null) {
      periodlist = [];
      json['periodlist'].forEach((v) {
        periodlist?.add(Periodlist.fromJson(v));
      });
    }
  }

  String? day;
  String? time;
  List<Periodlist>? periodlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['time'] = time;
    if (periodlist != null) {
      map['periodlist'] = periodlist?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// timeduration : "09.00-10.01"
/// subject : "EVS"
/// teacher : "Divya R"

class Periodlist {
  Periodlist({
    this.timeduration,
    this.subject,
    this.teacher,
  });

  Periodlist.fromJson(dynamic json) {
    timeduration = json['timeduration'];
    subject = ConstUtils.getUserData().usertype ==
            ConstUtils.kGetRoleIndex(VariableUtils.parent)
        ? json['subject']
        : json['subject_name'];
    teacher = ConstUtils.getUserData().usertype ==
            ConstUtils.kGetRoleIndex(VariableUtils.parent)
        ? json['teacher']
        : json['class_name'];
  }

  String? timeduration;
  String? subject;
  String? teacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timeduration'] = timeduration;
    map['subject'] = subject;
    map['teacher'] = teacher;
    return map;
  }
}
