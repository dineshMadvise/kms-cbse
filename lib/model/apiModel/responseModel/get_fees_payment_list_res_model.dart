/// DATA : [{"payment_date":"2021-05-12","refno":"FEE/000008","feename":"admission fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-8.pdf"},{"payment_date":"2021-05-12","refno":"FEE/000009","feename":"Enrollment fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-3-9.pdf"},{"payment_date":"2021-05-12","refno":"FEE/000010","feename":"Tuition fee","paid_amount":"3000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-5-10.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000046","feename":"Books fee","paid_amount":"3500.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-4-46.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000047","feename":"Uniform and shoe","paid_amount":"1500.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-7-47.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000048","feename":"Term fee 1","paid_amount":"8000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-8-48.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000049","feename":"Term fee 2","paid_amount":"7600.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-9-49.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000050","feename":"Term fee 3","paid_amount":"5400.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-10-50.pdf"},{"payment_date":"2021-06-28","refno":"FEE/000051","feename":"library fee","paid_amount":"500.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-6-51.pdf"},{"payment_date":"2021-09-08","refno":"FEE/000180","feename":"Tuition fee","paid_amount":"2000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-5-180.pdf"},{"payment_date":"2022-02-18","refno":"FEE/000235","feename":"admission fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-235.pdf"},{"payment_date":"2022-02-18","refno":"FEE/000236","feename":"admission fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-236.pdf"},{"payment_date":"2022-02-18","refno":"FEE/000237","feename":"admission fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-237.pdf"},{"payment_date":"2022-02-18","refno":"FEE/000238","feename":"admission fee","paid_amount":"1000.00","receipt":"https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-238.pdf"}]
/// status : "OK"

class GetFeesPaymentListResModel {
  GetFeesPaymentListResModel({this.data, this.status, this.msg});

  GetFeesPaymentListResModel.fromJson(dynamic json) {
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
}

/// payment_date : "2021-05-12"
/// refno : "FEE/000008"
/// feename : "admission fee"
/// paid_amount : "1000.00"
/// receipt : "https://mspeducare.com/demoschool/public/uploads/payment/PAYMEENT-RECEIPT-INDIVIDUAL-4-2-8.pdf"

class Data {
  Data({
    String? paymentDate,
    String? refno,
    String? feename,
    String? paidAmount,
    String? receipt,
  }) {
    _paymentDate = paymentDate;
    _refno = refno;
    _feename = feename;
    _paidAmount = paidAmount;
    _receipt = receipt;
  }

  Data.fromJson(dynamic json) {
    _paymentDate = json['payment_date'];
    _refno = json['refno'];
    _feename = json['feename'];
    _paidAmount = json['paid_amount'];
    _receipt = json['receipt'];
  }

  String? _paymentDate;
  String? _refno;
  String? _feename;
  String? _paidAmount;
  String? _receipt;

  String? get paymentDate => _paymentDate;

  String? get refno => _refno;

  String? get feename => _feename;

  String? get paidAmount => _paidAmount;

  String? get receipt => _receipt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_date'] = _paymentDate;
    map['refno'] = _refno;
    map['feename'] = _feename;
    map['paid_amount'] = _paidAmount;
    map['receipt'] = _receipt;
    return map;
  }
}
