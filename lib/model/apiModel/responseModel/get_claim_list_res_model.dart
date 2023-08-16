/// DATA : [{"updated_on":"2022-01-08 10:05:17","refno":"RECEIPT/000055","payment_status":"Paid","created_on":"08 Jan 2022","payee_name":"seenivasan priya","expense_type":"Petrol","payment_by":"Cash","amount_exp":"08 Jan 2022","description":"When I was in out ward, I spent $3,000 on petrol ","attachment":"https://mspeducare.com/demoschool/public/uploads/20220108125030-receipt.pdf"},{"updated_on":"2021-12-15 10:30:32","refno":"RECEIPT/000052","payment_status":"Paid","created_on":"15 Dec 2021","payee_name":"seenivasan priya","expense_type":"cleaning goods","payment_by":"Cash","amount_exp":"15 Dec 2021","description":"I spent 2000 rupees to cleaning","attachment":""},{"updated_on":"2021-11-23 06:48:24","refno":"RECEIPT/000043","payment_status":"Paid","created_on":"23 Nov 2021","payee_name":"seenivasan priya","expense_type":"  school excersion","payment_by":"Cash","amount_exp":"23 Nov 2021","description":"i spent 2500 in school excersion tour ","attachment":"https://mspeducare.com/demoschool/public/uploads/20211123120803-fees slip.png"},{"updated_on":"2021-11-23 06:15:49","refno":"RECEIPT/000042","payment_status":"Paid","created_on":"23 Nov 2021","payee_name":"seenivasan priya","expense_type":"Cleaning utensils","payment_by":"Cash","amount_exp":"23 Nov 2021","description":"i spent money for cleaning untensills","attachment":"https://mspeducare.com/demoschool/public/uploads/20211123114048-fees slip.png"},{"updated_on":"2021-11-22 11:35:17","refno":"","payment_status":"Waiting for Approval","created_on":"07 Aug 2021","payee_name":"seenivasan priya","expense_type":"Refreshment","payment_by":"Cash","amount_exp":"07 Aug 2021","description":"","attachment":""},{"updated_on":"2021-08-07 10:16:57","refno":"RECEIPT/000027","payment_status":"Paid","created_on":"07 Aug 2021","payee_name":"seenivasan priya","expense_type":"Refreshment","payment_by":"Cheque","amount_exp":"07 Aug 2021","description":"","attachment":""},{"updated_on":"2021-08-03 09:13:32","refno":"RECEIPT/000020","payment_status":"Paid","created_on":"03 Aug 2021","payee_name":"seenivasan priya","expense_type":"cleaning goods","payment_by":"Cash","amount_exp":"03 Aug 2021","description":"","attachment":""},{"updated_on":"2021-08-03 09:22:01","refno":"RECEIPT/000021","payment_status":"Paid","created_on":"03 Aug 2021","payee_name":"seenivasan priya","expense_type":"  school excersion","payment_by":"Cash","amount_exp":"03 Aug 2021","description":"yesterday we went to thirupukundram  with grade 3 student . i have spent my money","attachment":"https://mspeducare.com/demoschool/public/uploads/20210803095721-print-common-receipt (2).pdf"},{"updated_on":"2021-07-10 07:09:03","refno":"RECEIPT/000016","payment_status":"Paid","created_on":"10 Jul 2021","payee_name":"seenivasan priya","expense_type":"Refreshment","payment_by":"Cash","amount_exp":"10 Jul 2021","description":"today we went small trip  gandhi musium  with grade 3 stdent ,,,that time  i spent   500in   side ","attachment":""},{"updated_on":"2021-09-06 10:57:20","refno":"RECEIPT/000040","payment_status":"Paid","created_on":"10 Jul 2021","payee_name":"seenivasan priya","expense_type":"Refreshment","payment_by":"Cash","amount_exp":"10 Jul 2021","description":"Today we went trip at  thirupurakunram  with grade 3 student only. I spent 300 money from my side ","attachment":"https://mspeducare.com/demoschool/public/uploads/100721120920.jpeg"}]
/// status : "OK"

class GetClaimListResModel {
  GetClaimListResModel({this.data, this.status, this.msg});

  GetClaimListResModel.fromJson(dynamic json) {
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

/// updated_on : "2022-01-08 10:05:17"
/// refno : "RECEIPT/000055"
/// payment_status : "Paid"
/// created_on : "08 Jan 2022"
/// payee_name : "seenivasan priya"
/// expense_type : "Petrol"
/// payment_by : "Cash"
/// amount_exp : "08 Jan 2022"
/// description : "When I was in out ward, I spent $3,000 on petrol "
/// attachment : "https://mspeducare.com/demoschool/public/uploads/20220108125030-receipt.pdf"

class Data {
  Data(
      {this.updatedOn,
      this.refno,
      this.paymentStatus,
      this.createdOn,
      this.payeeName,
      this.expenseType,
      this.paymentBy,
      this.amountExp,
      this.description,
      this.attachment,
      this.amount});

  Data.fromJson(dynamic json) {
    updatedOn = json['updated_on'];
    refno = json['refno'];
    paymentStatus = json['payment_status'];
    createdOn = json['created_on'];
    payeeName = json['payee_name'];
    expenseType = json['expense_type'];
    paymentBy = json['payment_by'];
    amountExp = json['amount_exp'];
    description = json['description'];
    attachment = json['attachment'] ?? '';
    amount = json['amount'];
  }

  String? updatedOn;
  String? refno;
  String? paymentStatus;
  String? createdOn;
  String? payeeName;
  String? expenseType;
  String? paymentBy;
  String? amountExp;
  String? description;
  String? attachment;
  String? amount;
}
