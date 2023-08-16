/// DATA : [{"leave_date":"14 Sep 2021-16 Sep 2021","leave_name":"Sick Leave","status":"Approved","request_on":"15 Sep 2021","approvedby":"admin ","reason":"As I am Suffering from severe head pain. Kindly grant me leave for 3 days.","attachment":"","comment_by_approver":""}]
/// status : "OK"

class GetLeaveReqListResModel {
  GetLeaveReqListResModel({this.data, this.status, this.msg});

  GetLeaveReqListResModel.fromJson(dynamic json) {
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

/// leave_date : "14 Sep 2021-16 Sep 2021"
/// leave_name : "Sick Leave"
/// status : "Approved"
/// request_on : "15 Sep 2021"
/// approvedby : "admin "
/// reason : "As I am Suffering from severe head pain. Kindly grant me leave for 3 days."
/// attachment : ""
/// comment_by_approver : ""

class Data {
  Data({
    this.leaveDate,
    this.leaveName,
    this.status,
    this.requestOn,
    this.approvedby,
    this.reason,
    this.attachment,
    this.commentByApprover,
  });

  Data.fromJson(dynamic json) {
    leaveDate = json['leave_date'];
    leaveName = json['leave_name'];
    status = json['status'];
    requestOn = json['request_on'];
    approvedby = json['approvedby'];
    reason = json['reason'];
    attachment = json['attachment'];
    commentByApprover = json['comment_by_approver'];
  }
  String? leaveDate;
  String? leaveName;
  String? status;
  String? requestOn;
  String? approvedby;
  String? reason;
  String? attachment;
  String? commentByApprover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leave_date'] = leaveDate;
    map['leave_name'] = leaveName;
    map['status'] = status;
    map['request_on'] = requestOn;
    map['approvedby'] = approvedby;
    map['reason'] = reason;
    map['attachment'] = attachment ?? '';
    map['comment_by_approver'] = commentByApprover ?? "";
    return map;
  }
}
