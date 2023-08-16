class GetApplyPaymentListResModel {
  GetApplyPaymentListResModel({
    this.data,
    this.status,
  });

  GetApplyPaymentListResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(PaymentData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<PaymentData>? data = [];
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

class PaymentData {
  PaymentData({
    this.dateTime,
    this.feeName,
    this.studentName,
    this.paidAmount,
    this.classStr,
    this.paymentMode,
    this.paymentDate,
    this.receipt,
    this.receiptUrl,
  });

  PaymentData.fromJson(dynamic json) {
    dateTime = json['date_time'];
    feeName = json['fee_name'];
    studentName = json['student_name'];
    paidAmount = json['paid_amount'];
    classStr = json['class'];
    paymentMode = json['payment_mode'];
    paymentDate = json['payment_date'];
    receipt = json['receipt'];
    receiptUrl = json['receipt_url'];
  }

  String? dateTime;
  String? feeName;
  String? studentName;
  String? paidAmount;
  String? classStr;
  String? paymentMode;
  String? paymentDate;
  String? receipt;
  String? receiptUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date_time'] = dateTime;
    map['fee_name'] = feeName;
    map['student_name'] = studentName;
    map['paid_amount'] = paidAmount;
    map['class'] = classStr;
    map['payment_mode'] = paymentMode;
    map['payment_date'] = paymentDate;
    map['receipt'] = receipt;
    map['receipt_url'] = receiptUrl;
    return map;
  }
}
