/// DATA : [{"complaint_date":"23 Mar 2022","department_name":"Maintenance","user_type":"Parents","name":null,"suggestion":"pls maintain rest rooms properly","feedback":""},{"complaint_date":"23 Mar 2022","department_name":"Maintenance","user_type":"Parents","name":null,"suggestion":"pls maintain rest rooms properly","feedback":""},{"complaint_date":"23 Mar 2022","department_name":"Maintenance","user_type":"Parents","name":null,"suggestion":"pls maintain rest rooms properly","feedback":""},{"complaint_date":"22 Mar 2022","department_name":"Maintenance","user_type":"Parents","name":null,"suggestion":"pls maintain rest rooms properly","feedback":""},{"complaint_date":"24 Dec 2021","department_name":"Transport","user_type":"Teacher","name":null,"suggestion":"Sosksn","feedback":""},{"complaint_date":"14 Dec 2021","department_name":"Transport","user_type":"Parents","name":null,"suggestion":"My area bus come  late at every day ","feedback":""},{"complaint_date":"14 Dec 2021","department_name":"Maintenance","user_type":"Teacher","name":null,"suggestion":"Jdjjfkf","feedback":""},{"complaint_date":"14 Dec 2021","department_name":"Maintenance","user_type":"Teacher","name":null,"suggestion":"cdfafadg","feedback":""},{"complaint_date":"12 Aug 2021","department_name":"Accounts","user_type":"STAFF","name":null,"suggestion":"System not worked prperly","feedback":"ok ..wait  two days....i will change your system "},{"complaint_date":"12 Aug 2021","department_name":"Transport","user_type":"Parents","name":null,"suggestion":"school bus not come propoerly","feedback":""},{"complaint_date":"11 Aug 2021","department_name":"Maintenance","user_type":"Teacher","name":null,"suggestion":"our class room window not properly closed ","feedback":"Let give me one or two days.....after that definitely  your class room  window problem solved "},{"complaint_date":"31 Jul 2021","department_name":"Maintenance","user_type":"Parents","name":null,"suggestion":"pls maintain rest rooms properly","feedback":"yes sure we look into it"},{"complaint_date":"30 Jul 2021","department_name":"Transport","user_type":"Teacher","name":null,"suggestion":"Arrival of school bus is late everyday. So, Requesting you to take action accordingly.","feedback":""}]
/// status : "OK"

class GetComplaintListResModel {
  GetComplaintListResModel({this.data, this.status, this.msg});

  GetComplaintListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(ComplainData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<ComplainData>? data = [];
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

/// complaint_date : "23 Mar 2022"
/// department_name : "Maintenance"
/// user_type : "Parents"
/// name : null
/// suggestion : "pls maintain rest rooms properly"
/// feedback : ""

class ComplainData {
  ComplainData(
      {this.complaintDate,
      this.departmentName,
      this.userType,
      this.name,
      this.suggestion,
      this.feedback,
      this.id,
      this.attachment,
      this.mobileNumber});

  ComplainData.fromJson(dynamic json) {
    complaintDate = json['complaint_date'];
    departmentName = json['department_name'];
    userType = json['user_type']==""?null:json['user_type'];
    name = json['name'] == "" ? null : json['name'];
    suggestion = json['suggestion'];
    feedback = json['feedback'];
    id = json['id'];
    mobileNumber = json['mobile_no'] == "" ? null : json['mobile_no'];
    attachment = json['attachment'] ?? '';
  }

  String? complaintDate;
  String? departmentName;
  String? userType;
  dynamic name;
  String? suggestion;
  String? feedback;
  String? id;
  String? attachment;
  String? mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['complaint_date'] = complaintDate;
    map['department_name'] = departmentName;
    map['user_type'] = userType;
    map['name'] = name;
    map['suggestion'] = suggestion;
    map['feedback'] = feedback;
    map['mobile_no'] = mobileNumber;
    return map;
  }
}
