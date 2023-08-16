import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetEnquiryListResModel {
  GetEnquiryListResModel({this.data, this.status, this.msg});

  GetEnquiryListResModel.fromJson(dynamic json) {
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
    this.studentName,
    this.parentName,
    this.admissionForClass,
    this.area,
    this.contactNo,
    this.status,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    studentName = json['student_name'];
    parentName = json['parent_name'] == "" || json['parent_name'] == null
        ? VariableUtils.none
        : json['parent_name'];
    admissionForClass = json['admission_for_class'];
    area = json['area'] == "" || json['area'] == null
        ? VariableUtils.none
        : json['area'];
    contactNo = json['contact_no'] == "" || json['contact_no'] == null
        ? VariableUtils.none
        : json['contact_no'];
    status = json['status'];
  }

  String? id;
  String? studentName;
  String? parentName;
  String? admissionForClass;
  String? area;
  String? contactNo;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['student_name'] = studentName;
    map['parent_name'] = parentName;
    map['admission_for_class'] = admissionForClass;
    map['area'] = area;
    map['contact_no'] = contactNo;
    map['status'] = status;
    return map;
  }
}
