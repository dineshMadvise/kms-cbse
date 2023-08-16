// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_exam_score_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_exam_score_list_repo.dart';
import 'package:msp_educare_demo/model/repo/update_exam_score_repo.dart';

class ExamScoreViewModel extends GetxController {
  ApiResponse getExamScoreListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateExamScoreApiResponse = ApiResponse.initial('INITIAL');

  /// GET EXAM SCORE LIST
  Future<void> getExamScoreListList() async {
    getExamScoreListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetExamScoreListRepo().getExamScoreList();
      getExamScoreListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExamScoreListApiResponse ERROR :=> $e');
      getExamScoreListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

/// UPDATE EXAM SCORE
Future<void> updateExamScore(UpdateExamScoreReqModel reqModel) async {
  updateExamScoreApiResponse = ApiResponse.loading('LOADING');
  update();
  try {
    final response = await UpdateExamScoreRepo().updateExamScoreRepo(reqModel);
    updateExamScoreApiResponse = ApiResponse.complete(response);
  } catch (e) {
    print('updateExamScoreApiResponse ERROR :=> $e');
    updateExamScoreApiResponse = ApiResponse.error('ERROR');
  }
  update();
}
}
