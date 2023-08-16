/// DATA : [{"leave_date":"23 Mar 2022","leave_name":"Casual Leave","status":"Pending","user_type":"STAFF","created_on":"23 Mar 2022","name":null,"id":"198","reason":"","attachment":"","approved_reason":""},{"leave_date":"22 Mar 2022","leave_name":"Sick Leave","status":"Pending","user_type":"Teacher","created_on":"21 Mar 2022","name":null,"id":"197","reason":"","attachment":"","approved_reason":""},{"leave_date":"15 Dec 2021-16 Dec 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"15 Dec 2021","name":null,"id":"194","reason":"","attachment":"","approved_reason":""},{"leave_date":"07 Dec 2021-09 Dec 2021","leave_name":"Sick Leave","status":"Pending","user_type":"Teacher","created_on":"07 Dec 2021","name":null,"id":"191","reason":"Not well from yesterday.","attachment":"https://mspeducare.com/demoschool/public/uploads/20211207133715-leaveletter.docx","approved_reason":""},{"leave_date":"15 Nov 2021-16 Nov 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"13 Nov 2021","name":null,"id":"186","reason":"","attachment":"","approved_reason":""},{"leave_date":"15 Nov 2021-16 Nov 2021","leave_name":"Casual Leave","status":"Approved","user_type":"Teacher","created_on":"15 Nov 2021","name":null,"id":"187","reason":"","attachment":"","approved_reason":""},{"leave_date":"15 Nov 2021-16 Nov 2021","leave_name":"Casual Leave","status":"Approved","user_type":"Teacher","created_on":"15 Nov 2021","name":null,"id":"188","reason":"","attachment":"","approved_reason":""},{"leave_date":"15 Nov 2021-16 Nov 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"15 Nov 2021","name":null,"id":"189","reason":"","attachment":"","approved_reason":""},{"leave_date":"15 Nov 2021-16 Nov 2021","leave_name":"Casual Leave","status":"Pending","user_type":"Teacher","created_on":"15 Nov 2021","name":null,"id":"190","reason":"","attachment":"","approved_reason":""},{"leave_date":"10 Nov 2021-11 Nov 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"10 Nov 2021","name":null,"id":"185","reason":"","attachment":"","approved_reason":""},{"leave_date":"01 Nov 2021-30 Nov 2021","leave_name":"maternity leave","status":"Approved","user_type":"Teacher","created_on":"22 Dec 2021","name":null,"id":"195","reason":"","attachment":"","approved_reason":""},{"leave_date":"28 Oct 2021-29 Oct 2021","leave_name":"Sick Leave","status":"Pending","user_type":"Teacher","created_on":"27 Oct 2021","name":null,"id":"182","reason":"","attachment":"","approved_reason":""},{"leave_date":"28 Oct 2021","leave_name":"Sick Leave","status":"Approved","user_type":"STAFF","created_on":"28 Oct 2021","name":null,"id":"183","reason":"","attachment":"","approved_reason":""},{"leave_date":"28 Oct 2021-29 Oct 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"28 Oct 2021","name":null,"id":"184","reason":"","attachment":"","approved_reason":""},{"leave_date":"18 Oct 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"16 Oct 2021","name":null,"id":"180","reason":"","attachment":"","approved_reason":""},{"leave_date":"04 Oct 2021-05 Oct 2021","leave_name":"Casual Leave","status":"Approved","user_type":"Teacher","created_on":"07 Dec 2021","name":null,"id":"192","reason":"Going to native","attachment":"https://mspeducare.com/demoschool/public/uploads/20211207134046-leaveletter.docx","approved_reason":""},{"leave_date":"14 Sep 2021-16 Sep 2021","leave_name":"Sick Leave","status":"Approved","user_type":"Teacher","created_on":"15 Sep 2021","name":null,"id":"175","reason":"As I am Suffering from severe head pain. Kindly grant me leave for 3 days.","attachment":"","approved_reason":""}]
/// status : "OK"

class GetLeaveApprovalListResModel {
  GetLeaveApprovalListResModel({this.data, this.status, this.msg});

  GetLeaveApprovalListResModel.fromJson(dynamic json) {
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

/// leave_date : "23 Mar 2022"
/// leave_name : "Casual Leave"
/// status : "Pending"
/// user_type : "STAFF"
/// created_on : "23 Mar 2022"
/// name : null
/// id : "198"
/// reason : ""
/// attachment : ""
/// approved_reason : ""

class Data {
  Data({
    this.leaveDate,
    this.leaveName,
    this.status,
    this.userType,
    this.createdOn,
    this.name,
    this.id,
    this.reason,
    this.attachment,
    this.approvedReason,
  });

  Data.fromJson(dynamic json) {
    leaveDate = json['leave_date'];
    leaveName = json['leave_name'];
    status = json['status'];
    userType = json['user_type'];
    createdOn = json['created_on'];
    name = json['name'];
    id = json['id'];
    reason = json['reason'];
    attachment = json['attachment'];
    approvedReason = json['approved_reason'];
  }
  String? leaveDate;
  String? leaveName;
  String? status;
  String? userType;
  String? createdOn;
  dynamic name;
  String? id;
  String? reason;
  String? attachment;
  String? approvedReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leave_date'] = leaveDate;
    map['leave_name'] = leaveName;
    map['status'] = status;
    map['user_type'] = userType;
    map['created_on'] = createdOn;
    map['name'] = name;
    map['id'] = id;
    map['reason'] = reason;
    map['attachment'] = attachment ?? '';
    map['approved_reason'] = approvedReason;
    return map;
  }
}
