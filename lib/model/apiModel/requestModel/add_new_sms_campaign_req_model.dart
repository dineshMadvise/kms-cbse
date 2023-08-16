import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class AddNewSmsCampaignReqModel {
  AddNewSmsCampaignReqModel({
      this.templateId,
      this.campaignName, 
      this.description, 
      this.publishTo, 
      this.studentId, 
      this.sectionId, 
      this.classId,});

  AddNewSmsCampaignReqModel.fromJson(dynamic json) {
    templateId = json['template_id'];
    campaignName = json['campaign_name'];
    description = json['description'];
    publishTo = json['publish_to'];
    studentId = json['student_id'];
    sectionId = json['section_id'];
    classId = json['class_id'];
  }
  String? templateId;
  String? campaignName;
  String? description;
  String? publishTo;
  String? studentId;
  String? sectionId;
  String? classId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();

    map['action'] = 'savesmsCampaign';
    map['user_type'] = userData.usertype;
    map['template_id'] = templateId;
    map['campaign_name'] = campaignName;
    map['description'] = description;
    map['publish_to'] = publishTo;
    map['student_id'] = studentId;
    map['section_id'] = sectionId;
    map['class_id'] = classId;
    return map;
  }

}