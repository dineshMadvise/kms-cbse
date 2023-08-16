/// DATA : [{"certificate_name":"completion certficate","created_on":"26-05-2021","certificate":"https://mspeducare.com/demoschool/public/uploads/certificate/4/certificate-of-completion_red-pattern.docx"},{"certificate_name":"certificate of course completion","created_on":"01-06-2021","certificate":"https://mspeducare.com/demoschool/public/uploads/certificate/4/course-completion-certificate.docx"},{"certificate_name":"Participation certificate","created_on":"07-01-2022","certificate":"https://mspeducare.com/demoschool/public/uploads/certificate/4/test-certificate.docx"}]
/// status : "OK"

class GetCertificateListResModel {
  GetCertificateListResModel({this.data, this.status, this.msg});

  GetCertificateListResModel.fromJson(dynamic json) {
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

/// certificate_name : "completion certficate"
/// created_on : "26-05-2021"
/// certificate : "https://mspeducare.com/demoschool/public/uploads/certificate/4/certificate-of-completion_red-pattern.docx"

class Data {
  Data({
    this.certificateName,
    this.createdOn,
    this.certificate,
  });

  Data.fromJson(dynamic json) {
    certificateName = json['certificate_name'];
    createdOn = json['created_on'];
    certificate = json['certificate'];
  }

  String? certificateName;
  String? createdOn;
  String? certificate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['certificate_name'] = certificateName;
    map['created_on'] = createdOn;
    map['certificate'] = certificate;
    return map;
  }
}
