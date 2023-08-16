import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class ApplyFeesPaymentReqModel {
  String? feesId;
  String? paidAmount;
  String? txAmount;
  String? transactionId;

  ApplyFeesPaymentReqModel(
      {this.paidAmount, this.feesId, this.transactionId, this.txAmount});

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    return {
      "action": "applyPayment",
      "user_type": userData.usertype,
      "user_id": userData.userid,
      "student_id":
          userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? studentData.id
              : "0",
      "fee_id": feesId,
      "paid_amount": paidAmount,
      "tx_amount": txAmount,
      "transaction_id": transactionId
    };
  }
}
