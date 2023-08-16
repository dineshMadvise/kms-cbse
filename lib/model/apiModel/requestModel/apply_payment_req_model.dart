import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class ApplyPaymentReqModel {
  ApplyPaymentReqModel({
    this.classId,
    this.sectionId,
    this.studentId,
    this.feeId,
    this.feeAmount,
    this.bankId,
    this.dueDate,
    this.paymentDate,
    this.paidAmount,
    this.paymentMode,
    this.remark,
  });

  ApplyPaymentReqModel.fromJson(dynamic json) {
    classId = json['class_id'];
    sectionId = json['section_id'];
    studentId = json['student_id'];
    feeId = json['fee_id'];
    feeAmount = json['fee_amount'];
    bankId = json['bank_id'];
    dueDate = json['due_date'];
    paymentDate = json['payment_date'];
    paidAmount = json['paid_amount'];
    paymentMode = json['payment_mode'];
    remark = json['remark'];
  }

  String? classId;
  String? sectionId;
  String? studentId;
  String? feeId;
  String? feeAmount;
  String? bankId;
  String? dueDate;
  String? paymentDate;
  String? paidAmount;
  String? paymentMode;
  String? remark;

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    final map = <String, dynamic>{};
    map['action'] = "applyFeePayment";
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['student_id'] = studentId;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['fee_id'] = feeId;
    map['fee_amount'] = feeAmount;
    map['bank_id'] = bankId;
    map['due_date'] = dueDate;
    map['payment_date'] = paymentDate;
    map['paid_amount'] = paidAmount;
    map['payment_mode'] = paymentMode;
    map['remark'] = remark;
    return map;
  }
}
