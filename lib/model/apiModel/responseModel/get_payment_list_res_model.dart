class GetPaymentListResModel {
  GetPaymentListResModel({this.data, this.summary, this.status, this.msg});

  GetPaymentListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(FeesData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    if (json['SUMMARY'] != null) {
      if ((json['SUMMARY'] is Map<String, dynamic>)) {
        summary =
            json['SUMMARY'] != null ? Summary.fromJson(json['SUMMARY']) : null;
      }
    }

    status = json['status'];
    razorpayKey = json['razorpay_key'];
    paymentTransactionPer = json['payment_transaction_per'];
  }

  List<FeesData>? data = [];
  Summary? summary;
  String? status;
  String? msg;
  String? razorpayKey;
  String? paymentTransactionPer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      map['SUMMARY'] = summary?.toJson();
    }
    map['status'] = status;
    map['razorpay_key'] = razorpayKey;
    map['payment_transaction_per'] = paymentTransactionPer;
    return map;
  }
}

class Summary {
  Summary({
    this.totalDemandAmount,
    this.totPaidAmount,
    this.totPending,
    this.studentClass,
    this.receipt,
    this.studentId,
    this.studentDob,
    this.studentProfile,
  });

  Summary.fromJson(dynamic json) {
    totalDemandAmount =
        json['total_demand_amount'] == "" || json['total_demand_amount'] == null
            ? "0.0"
            : json['total_demand_amount'];
    totPaidAmount =
        json['tot_paid_amount'] == "" || json['tot_paid_amount'] == null
            ? "0.0"
            : json['tot_paid_amount'];
    totPending = json['tot_Pending'];
    studentClass = json['student_class'];
    receipt = json['receipt'];
    studentId = json['student_id'];
    studentDob = json['student_dob'];
    studentProfile = json['student_profile'];
  }

  String? totalDemandAmount;
  dynamic totPaidAmount;
  int? totPending;
  String? studentClass;
  String? receipt;
  String? studentId;
  dynamic studentDob;
  dynamic studentProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_demand_amount'] = totalDemandAmount;
    map['tot_paid_amount'] = totPaidAmount;
    map['tot_Pending'] = totPending;
    map['student_class'] = studentClass;
    map['receipt'] = receipt;
    map['student_id'] = studentId;
    map['student_dob'] = studentDob;
    map['student_profile'] = studentProfile;
    return map;
  }
}

class FeesData {
  FeesData({
    this.feeType,
    this.demandAmount,
    this.paidAmt,
    this.feeId
  });

  FeesData.fromJson(dynamic json) {
    feeType = json['fee_type'];
    feeId = json['fee_id'];
    demandAmount = json['demand_amount'] == "" || json['demand_amount'] == null
        ? 0
        : num.parse(json['demand_amount'].toString());
    paidAmt = json['paid_amt'] == "" || json['paid_amt'] == null
        ? 0
        : num.parse(json['paid_amt'].toString());
  }

  String? feeType;
  String? feeId;
  num? demandAmount;
  num? paidAmt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fee_type'] = feeType;
    map['fee_id'] = feeId;
    map['demand_amount'] = demandAmount;
    map['paid_amt'] = paidAmt;
    return map;
  }
}
