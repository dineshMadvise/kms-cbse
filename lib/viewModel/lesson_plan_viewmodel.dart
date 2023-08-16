// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_lesson_plan_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_lesson_plan_repo.dart';
import 'package:msp_educare_demo/model/repo/lesson_plan_repo.dart';
import 'package:msp_educare_demo/model/repo/update_lesson_plan_status_repo.dart';

class LessonPlanViewModel extends GetxController {
  ApiResponse getLessonPlanListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateLessonPlanListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse addLessonPlanListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse deleteLessonPlanApiResponse = ApiResponse.initial('INITIAL');

  void init(){
    updateLessonPlanListApiResponse = ApiResponse.initial('INITIAL');
    update();
  }
  /// GET LESSON LIST
  Future<void> getLessonPlanList() async {
    getLessonPlanListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetLessonPlanRepo().getLessonPlanRepo();
      getLessonPlanListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getLessonPlanListApiResponse ERROR :=> $e');
      getLessonPlanListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE LESSON PLAN STATUS
  Future<void> updateLessonPlanStatus(UpdateLessonPlanStatusReqModel reqModel) async {
    updateLessonPlanListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await UpdateLessonPlanStatusRepo().updateLessonPlanStatusRepo(reqModel);
      updateLessonPlanListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateLessonPlanListApiResponse ERROR :=> $e');
      updateLessonPlanListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


  /// ADD LESSON PLAN

  Future<void> addLessonPlanStatus( AddLessonPlanReqModel reqModel) async {
    addLessonPlanListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await LessonPlanRepo().addLessonPlanStatusRepo(reqModel);
      addLessonPlanListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('addLessonPlanListApiResponse ERROR :=> $e');
      addLessonPlanListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


  /// DELETE LESSON PLAN

  Future<void> deleteLessonPlan(String lessonId) async {
    deleteLessonPlanApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await LessonPlanRepo().deleteLessonPlanRepo(lessonId);
      deleteLessonPlanApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('deleteLessonPlanApiResponse ERROR :=> $e');
      deleteLessonPlanApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

}
