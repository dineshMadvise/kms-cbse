import 'package:flutter/material.dart';
// Import other necessary dependencies and classes.

class DailyReportResModel {
  DailyReportResModel({
    this.url,
    this.status,
  });

  DailyReportResModel.fromJson(dynamic json) {
    url = json['URL'];
    status = json['status'];
  }

  String? url;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['URL'] = url;
    map['status'] = status;
    return map;
  }
}

// Your other code and classes here.
