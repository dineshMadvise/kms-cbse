// ignore_for_file: prefer_final_fields, avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_h_w_remark_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/submit_homework_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_homework_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/add_homework_repo.dart';
import 'package:msp_educare_demo/model/repo/get_homework_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_homework_review_repo.dart';
import 'package:msp_educare_demo/model/repo/submit_homework_repo.dart';

class HomeWorkViewModel extends GetxController {
  List<String> _selectedSectionList = [];

  List<String> get selectedSectionList => _selectedSectionList;

  void clearSelectedSectionList() {
    _selectedSectionList.clear();
    // update();
  }

  void setSectionList(String id) {
    if (_selectedSectionList.contains(id)) {
      _selectedSectionList.remove(id);
    } else {
      _selectedSectionList.add(id);
    }
    update();
  }

  String _selectedFile = '';

  String get selectedFile => _selectedFile;

  set selectedFile(String value) {
    _selectedFile = value;
    update();
  }

  List _expansionPanelList = [];

  List get expansionPanelList => _expansionPanelList;

  void setExpansionPanelList(int index) {
    if (_expansionPanelList.contains(index)) {
      _expansionPanelList.remove(index);
    } else {
      _expansionPanelList.add(index);
    }
    update();
  }

  void clearExpansionPanelList() {
    _expansionPanelList.clear();
    update();
  }

  void initClearData() {
    addHomeworkApiResponse = ApiResponse.initial('INITIAL');
    _selectedFile = "";
    // update();
  }

  ApiResponse addHomeworkApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse submitHomeworkApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveHomeworkReviewApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getHomeworkListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateHomeworkApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getHomeworkDetailApiResponse = ApiResponse.initial('INITIAL');

  /// GET HOMEWORK LIST
  Future<void> getHomeworkList() async {
    getHomeworkListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetHomeworkListRepo().getHomeworkList();
      getHomeworkListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getHomeworkListApiResponse ERROR :=> $e');
      getHomeworkListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET HOMEWORK DETAIL
  Future<void> getHomeworkDetail(String homeworkId) async {
    getHomeworkDetailApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response =
          await GetHomeworkDetailRepo().getHomeworkDetail(homeworkId);
      getHomeworkDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getHomeworkDetailApiResponse ERROR :=> $e');
      getHomeworkDetailApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// ADD HOMEWORK
  Future<void> addHomeworkList(AddHomeworkReqModel reqModel) async {
    addHomeworkApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await AddHomeworkRepo().addHomework(reqModel);
      addHomeworkApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addHomeworkApiResponse ERROR :=> $e');
      addHomeworkApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SUBMIT HOMEWORK
  Future<void> submitHomeworkList(SubmitHomeworkReqModel reqModel) async {
    submitHomeworkApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SubmitHomeworkRepo().submitHomework(reqModel);
      submitHomeworkApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('submitHomeworkApiResponse ERROR :=> $e');
      submitHomeworkApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE HOMEWORK REVIEW
  Future<void> saveHomeworkReview(SaveHWRemarkReqModel reqModel) async {
    saveHomeworkReviewApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await SaveHomeworkReviewRepo().saveHomeworkReview(reqModel);
      saveHomeworkReviewApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveHomeworkReviewApiResponse ERROR :=> $e');
      saveHomeworkReviewApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE HOMEWORK
  Future<void> updateHomework(UpdateHomeworkReqModel reqModel) async {
    updateHomeworkApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await UpdateHomeworkRepo().updateHomework(reqModel);
      updateHomeworkApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateHomeworkApiResponse ERROR :=> $e');
      updateHomeworkApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
