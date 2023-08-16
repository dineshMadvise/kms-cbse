import 'dart:developer';

import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_announcement_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../viewModel/announcement_viewmodel.dart';

class AnnouncementLogic {
  static Future<void> getAnnounceCount(String id) async {
    AnnouncementViewModel _viewModel =
        Get.find(tag: AnnouncementViewModel().toString());
    await _viewModel.getAnnouncementCount(id);
    if (_viewModel.getAnnouncementCountApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.getAnnouncementCountApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        UserData userData = ConstUtils.getUserData();
        log('USER DATA :=>${userData.toJson()}');
        if (userData.usertype ==
            ConstUtils.kGetRoleIndex(VariableUtils.admin)) {
          _viewModel.getAnnouncementList();
        }

        // showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: VariableUtils.saveAnnounceCountFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  static Future<bool> saveAnnounceRemark(
      {required String annId, required String remark}) async {
    AnnouncementViewModel _viewModel =
        Get.find(tag: AnnouncementViewModel().toString());
    await _viewModel.saveAnnouncementRemark(annId: annId, remark: remark);
    if (_viewModel.saveAnnouncementRemarkApiResponse.status ==
        Status.COMPLETE) {
      CommonResModel response =
          _viewModel.saveAnnouncementRemarkApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getAnnouncementList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveAnnounceRemarkFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  static Future<bool> addAnnouncement(AddAnnouncementReqModel reqModel) async {
    AnnouncementViewModel _viewModel =
        Get.find(tag: AnnouncementViewModel().toString());
    if (reqModel.publishTo == VariableUtils.all ||
        reqModel.publishTo == VariableUtils.teacher) {
      reqModel.classId = "";
      reqModel.sectionId = "";
      reqModel.studId = "";
    } else if (reqModel.publishTo == VariableUtils.classStr) {
      reqModel.sectionId = "";
      reqModel.studId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      reqModel.classId = classIds;
    } else if (reqModel.publishTo == VariableUtils.classAndSection) {
      reqModel.studId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      final sectionIds =
          ConstUtils.convertListToString(_viewModel.selectedSectionList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      if (sectionIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniSection);
        return false;
      }
      reqModel.classId = classIds;
      reqModel.sectionId = sectionIds;
    } else {
      reqModel.sectionId = "";
      final classIds =
          ConstUtils.convertListToString(_viewModel.selectedClassList);
      final studIds =
          ConstUtils.convertListToString(_viewModel.selectedClassStudList);
      if (classIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniClass);
        return false;
      }
      if (studIds == '') {
        showToast(msg: VariableUtils.pleaseSelectMiniStud);
        return false;
      }
      reqModel.classId = classIds;
      reqModel.studId = studIds;
    }

    await _viewModel.addAnnouncementList(reqModel);
    if (_viewModel.addAnnouncementListApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.addAnnouncementListApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        _viewModel.getAnnouncementList();
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.addAnnouncementFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
