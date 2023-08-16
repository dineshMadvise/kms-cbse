// ignore_for_file: unnecessary_new

class GetFinancialReportResModel {
  GetFinancialReportResModel({
    this.data,
    this.status,
  });

  GetFinancialReportResModel.fromJson(dynamic json) {
    data = json['DATA'] != null ? Data.fromJson(json['DATA']) : null;
    status = json['status'];
  }
  Data? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class Data {
  Data({
    this.totalAmount,
    this.receivedAmount,
    this.pendingAmount,
    this.list,
  });

  Data.fromJson(dynamic json) {
    totalAmount = json['total_amount'] != null
        ? new TotalAmount.fromJson(json['total_amount'])
        : null;
    receivedAmount = json['received_amount'] != null
        ? new TotalAmount.fromJson(json['received_amount'])
        : null;
    pendingAmount = json['pending_amount'] != null
        ? new TotalAmount.fromJson(json['pending_amount'])
        : null;
    if (json['LIST'] != null) {
      list = [];
      json['LIST'].forEach((v) {
        list?.add(FinancialData.fromJson(v));
      });
    }
  }
  TotalAmount? totalAmount;
  TotalAmount? receivedAmount;
  TotalAmount? pendingAmount;
  List<FinancialData>? list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (totalAmount != null) {
      map['total_amount'] = totalAmount!.toJson();
    }
    if (receivedAmount != null) {
      map['received_amount'] = receivedAmount!.toJson();
    }
    if (pendingAmount != null) {
      map['pending_amount'] = pendingAmount!.toJson();
    }
    if (list != null) {
      map['LIST'] = list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TotalAmount {
  String? title;
  int? amount;

  TotalAmount({this.title, this.amount});

  TotalAmount.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['amount'] = amount;
    return data;
  }
}

class FinancialData {
  FinancialData({
    this.month,
    this.income,
    this.expense,
    this.salary,
  });

  FinancialData.fromJson(dynamic json) {
    month = json['Month'];
    income = json['Income'];
    expense = json['Expense'];
    salary = json['Salary'];
  }
  String? month;
  num? income;
  num? expense;
  num? salary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Month'] = month;
    map['Income'] = income;
    map['Expense'] = expense;
    map['Salary'] = salary;
    return map;
  }
}
