class GetProgressReportResModel {
  GetProgressReportResModel({this.data, this.status, this.msg});

  GetProgressReportResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
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
    this.title,
    this.createdOn,
    this.progressReport,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    createdOn = json['created_on'];
    progressReport = json['progress_report'];
  }

  String? title;
  String? createdOn;
  String? progressReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['created_on'] = createdOn;
    map['progress_report'] = progressReport;
    return map;
  }
}
