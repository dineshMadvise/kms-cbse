import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class AddLessonPlanReqModel {
  AddLessonPlanReqModel({
      this.actionType,
      this.lessonPlanId,
      this.classId, 
      this.subjectId, 
      this.startDate, 
      this.endDate, 
      this.objectives, 
      this.aids, 
      this.assignment, 
      this.evaluation,});

  AddLessonPlanReqModel.fromJson(dynamic json) {
    actionType = json['action_type'];
    lessonPlanId = json['lesson_plan_id'];
    classId = json['class_id'];
    subjectId = json['subject_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    objectives = json['objectives'];
    aids = json['aids'];
    assignment = json['assignment'];
    evaluation = json['evaluation'];
  }
  String? actionType;
  String? lessonPlanId;
  String? classId;
  String? subjectId;
  String? startDate;
  String? endDate;
  String? objectives;
  String? aids;
  String? assignment;
  String? evaluation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();

    map['action'] = 'addLessonPlan';
    map['action_type'] = actionType;
    map['lesson_plan_id'] = lessonPlanId;
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['class_id'] = classId;
    map['subject_id'] = subjectId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['objectives'] = objectives;
    map['aids'] = aids;
    map['assignment'] = assignment;
    map['evaluation'] = evaluation;
    return map;
  }

}