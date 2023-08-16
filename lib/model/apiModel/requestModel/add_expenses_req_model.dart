// ignore_for_file: prefer_collection_literals
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class EditExpensesReqModel {
  String? expenseId;
  String? date;
  String? expenseType;
  String? amount;
  String? description;
  String? attachment;
  String? paymentStatus;
  String? actionType;

  EditExpensesReqModel(
      {
        this.expenseId,
        this.date,
        this.expenseType,
        this.amount,
        this.description,
        this.attachment,
        this.paymentStatus,
        this.actionType,
      });

  EditExpensesReqModel.fromJson(Map<String, dynamic> json) {

    expenseId = json['expense_id'];
    actionType = json['action_type'];

    date = json['date'];
    expenseType = json['expense_type'];
    amount = json['amount'];
    description = json['description'];
    attachment = json['attachment'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    UserData userData = ConstUtils.getUserData();

    data['action'] = "saveExpenses";
    data['action_type'] = actionType;
    data['expense_id'] = expenseId;
    data['user_type'] = userData.usertype;
    data['user_id'] = userData.userid;
    data['date'] = date;
    data['expense_type'] = expenseType;
    data['amount'] = amount;
    data['description'] = description ?? '';
    data['attachment'] = attachment;
    data['payment_status'] =paymentStatus;
    return data;
  }
}
