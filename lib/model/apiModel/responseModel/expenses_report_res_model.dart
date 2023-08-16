// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this, prefer_void_to_null, unnecessary_question_mark

class GetExpensesReportResModel {


  GetExpensesReportResModel({this.data, this.status});

  GetExpensesReportResModel.fromJson(Map<String, dynamic> json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        if ((json['DATA'] as List<dynamic>).isEmpty) {
          msg = 'No record found';
        } else {
          json['DATA'].forEach((v) {
            data?.add(ExpensesData.fromJson(v));
          });
        }
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }
  List<ExpensesData>? data = [];
  String? status;
  String? msg;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['DATA'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ExpensesData {
  String? id;
  String? expenseType;
  String? payeeName;
  String? amount;
  String? paymentDate;
  String? paymentStatus;
  String? description;
  String? attachment;
  String? refno;
  Null? paymentBy;

  ExpensesData(
      {this.id,
      this.expenseType,
      this.payeeName,
      this.amount,
      this.paymentDate,
      this.paymentStatus,
      this.description,
      this.attachment,
      this.refno,
      this.paymentBy});

  ExpensesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseType = json['expense_type'];
    payeeName = json['payee_name'];
    amount = json['amount'];
    paymentDate = json['payment_date'];
    paymentStatus = json['payment_status'];
    description = json['description'];
    attachment = json['attachment'];
    refno = json['refno'];
    paymentBy = json['payment_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_type'] = this.expenseType;
    data['payee_name'] = this.payeeName;
    data['amount'] = this.amount;
    data['payment_date'] = this.paymentDate;
    data['payment_status'] = this.paymentStatus;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['refno'] = this.refno;
    data['payment_by'] = this.paymentBy;
    return data;
  }
}
