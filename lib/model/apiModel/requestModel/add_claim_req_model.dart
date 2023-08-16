import 'package:msp_educare_demo/utils/const_utils.dart';

import '../responseModel/login_res_model.dart';

class AddClaimReqModel {
  AddClaimReqModel({
    this.expenseType,
    this.fromDate,
    this.amount,
    this.description,
    this.attachment,
  });

  String? expenseType;
  String? fromDate;
  String? amount;
  String? description;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();

    map['action'] = "addClaimRequest";
    map['expense_type'] = expenseType;
    map['from_date'] = fromDate;
    map['amount'] = amount;
    map['description'] = description;
    map['attachment'] = attachment;
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    return map;
  }
}
