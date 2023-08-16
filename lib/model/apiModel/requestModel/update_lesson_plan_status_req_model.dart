import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class UpdateLessonPlanStatusReqModel {
  String? lessonPlanId;
  String? status;
  String? progress;
  String? remark;

  UpdateLessonPlanStatusReqModel({this.progress,this.status,this.lessonPlanId,this.remark});

  UpdateLessonPlanStatusReqModel.fromJson(Map<String,dynamic> json){
    progress=json['progress'];
    status=json['status'];
    lessonPlanId=json['lessonPlanId'];
    remark=json['remark'];
  }

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    return {
      "action": "updateLessonPlanStatus",
      "user_type": userData.usertype,
      "user_id": userData.userid,
      "lesson_plan_id": lessonPlanId,
      "status": status,
      "progress": progress,
      "remark": remark
    };
  }
}
