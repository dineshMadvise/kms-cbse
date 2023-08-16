class GetStudentPendingFeeResModel {
  GetStudentPendingFeeResModel({
    this.data,
    this.status,
  });

  GetStudentPendingFeeResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      data = [];
      json['DATA'].forEach((v) {
        data?.add(FeesData.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<FeesData>? data;
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

class FeesData {
  FeesData({
    this.feeId,
    this.feeType,
    this.feeAmount,
    this.balAmount,
    this.dueDate,
  });

  FeesData.fromJson(dynamic json) {
    feeId = json['fee_id'];
    feeType = json['fee_type'];
    feeAmount = json['fee_amount'];
    balAmount = json['bal_amount'];
    dueDate = json['due_date'];
  }
  String? feeId;
  String? feeType;
  int? feeAmount;
  int? balAmount;
  String? dueDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fee_id'] = feeId;
    map['fee_type'] = feeType;
    map['fee_amount'] = feeAmount;
    map['bal_amount'] = balAmount;
    map['due_date'] = dueDate;
    return map;
  }
}
