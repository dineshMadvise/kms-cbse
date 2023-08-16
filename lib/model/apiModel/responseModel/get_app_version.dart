class GetAppVersionResModel {
  GetAppVersionResModel({
    this.data,
    this.status,
  });

  GetAppVersionResModel.fromJson(dynamic json) {
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
    this.android,
    this.ios,
  });

  Data.fromJson(dynamic json) {
    android = json['Android'];
    ios = json['Ios'];
  }

  String? android;
  String? ios;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Android'] = android;
    map['Ios'] = ios;
    return map;
  }
}
