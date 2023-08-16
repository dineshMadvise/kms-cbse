class GetPayrollReportResModel {
  GetPayrollReportResModel({
    this.total,
    this.data,
    this.status,
  });

  GetPayrollReportResModel.fromJson(dynamic json) {
    total = json['TOTAL'] != null
        ? json['TOTAL'] is Map
            ? Total.fromJson(json['TOTAL'])
            : null
        : null;
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Total? total;
  List<Data>? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (total != null) {
      map['TOTAL'] = total?.toJson();
    }
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.staffName,
    this.month,
    this.totalLeave,
    this.salary,
    this.receipt,
  });

  Data.fromJson(dynamic json) {
    staffName = json['staff_name'];
    month = json['month'];
    totalLeave = json['total_leave'];
    salary = json['salary'];
    receipt = json['receipt'];
  }

  String? staffName;
  String? month;
  String? totalLeave;
  num? salary;
  String? receipt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['staff_name'] = staffName;
    map['month'] = month;
    map['total_leave'] = totalLeave;
    map['salary'] = salary;
    map['receipt'] = receipt;
    return map;
  }
}

class Total {
  Total({
    this.salary,
  });

  Total.fromJson(dynamic json) {
    salary = json['salary'];
  }

  num? salary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['salary'] = salary;
    return map;
  }
}
