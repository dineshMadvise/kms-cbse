class GetAcademicYearPlanListResModel {
  GetAcademicYearPlanListResModel({
    this.data,
    this.status,
  });

  GetAcademicYearPlanListResModel.fromJson(dynamic json) {
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
    this.title,
    this.descriptions,
    this.startDate,
    this.endDate,
    this.color,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    descriptions = json['descriptions'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    color = json['color'];
  }
  String? title;
  String? descriptions;
  String? startDate;
  String? endDate;
  String? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['descriptions'] = descriptions;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['color'] = color;
    return map;
  }
}

class CalenderData {
  CalenderData(
      {this.title,
      this.descriptions,
      this.startDate,
      this.endDate,
      this.color,
      this.matchDate});

  CalenderData.fromJson(dynamic json) {
    title = json['title'];
    descriptions = json['descriptions'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    color = json['color'];
    matchDate = json['match_date'];
  }
  String? title;
  String? descriptions;
  DateTime? startDate;
  DateTime? endDate;
  int? color;
  DateTime? matchDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['descriptions'] = descriptions;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['color'] = color;
    map['match_date'] = matchDate;
    return map;
  }
}
