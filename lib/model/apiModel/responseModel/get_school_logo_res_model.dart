/// DATA : [{"logo":"https://mspeducare.com/demoschool/public/uploads/SCHOOL_LOGO.png"}]
/// status : "OK"

class GetSchoolLogoResModel {
  GetSchoolLogoResModel({
    this.data,
    this.status,
  });

  GetSchoolLogoResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    }
    status = json['status'];
  }
  List<Data>? data;
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

/// logo : "https://mspeducare.com/demoschool/public/uploads/SCHOOL_LOGO.png"

class Data {
  Data({
    this.logo,
  });

  Data.fromJson(dynamic json) {
    logo = json['logo'];
  }
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = logo;
    return map;
  }
}
