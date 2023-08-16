/// DATA : [{"USER_ID":"0","ROLE_ID":"0","USER_TYPE":"0","DEPARTMENT_ID":"0"}]
/// status : "OK"

class LoginResModel {
  LoginResModel({
    this.data,
    this.status,
  });

  LoginResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(UserData.fromJson(v));
        });
      }
    }
    status = json['status'];
  }
  List<UserData>? data;
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

/// USER_ID : "0"
/// ROLE_ID : "0"
/// USER_TYPE : "0"
/// DEPARTMENT_ID : "0"

class UserData {
  UserData({
    this.userid,
    this.roleid,
    this.usertype,
    this.departmentid,
    this.mobileNumber,
    this.email
  });

  UserData.fromJson(dynamic json) {
    userid = json['USER_ID'];
    roleid = json['ROLE_ID'];
    usertype = json['USER_TYPE'];
    departmentid = json['DEPARTMENT_ID'];
    email = json['EMAIL'];
    mobileNumber = json['MOBILE_NO'];
  }
  String? userid;
  String? roleid;
  String? usertype;
  String? departmentid;
  String? email;
  String? mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USER_ID'] = userid;
    map['ROLE_ID'] = roleid;
    map['USER_TYPE'] = usertype;
    map['DEPARTMENT_ID'] = departmentid;
    map['EMAIL'] = email;
    map['MOBILE_NO'] = mobileNumber;
    return map;
  }
}
