// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_score_by_subject_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_exam_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_exam_score_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/apply_payment_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_attendance_status_repo.dart';
import 'package:msp_educare_demo/model/repo/get_claim_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_class_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_department_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_exam_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_exam_score_by_subject_repo.dart';
import 'package:msp_educare_demo/model/repo/get_exam_subject_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_leave_type_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_multiple_class_section_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_multiple_class_stud_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_nationality_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_section_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_subject_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_teacher_class_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_teacher_option_repo.dart';
import 'package:msp_educare_demo/model/repo/get_template_id_repo.dart';

import '../model/repo/get_edit_status_repo.dart';
import '../model/repo/get_edit_type_repo.dart';

class DropdownOptionViewModel extends GetxController {
  String _selectedSubject = "";
  String _selectedClass = "";
  String _selectedSection = "";
  String _selectedExam = "";
  String _selectedExamSubject = "";
  String _selectedType = "";
  List<ExamScore> examScore = [];

  List<String> attendanceStatusList = [];

  void setExamScore(ExamScore score) {
    int existIndex =
        examScore.indexWhere((element) => element.studId == score.studId);
    if (existIndex > -1) {
      examScore[existIndex] = score;
    } else {
      examScore.add(score);
    }
    update();
  }

  void clearExamScore() {
    examScore.clear();
    update();
  }

  String get selectedSection => _selectedSection;

  set selectedSection(String value) {
    _selectedSection = value;
    update();
  }

  String get selectedExam => _selectedExam;

  set selectedExam(String value) {
    _selectedExam = value;
    update();
  }

  String get selectedExamSubject => _selectedExamSubject;

  set selectedExamSubject(String value) {
    _selectedExamSubject = value;
    update();
  }

  String get selectedType => _selectedType;

  set selectedType(String value) {
    _selectedType = value;
    update();
  }

  String get selectedClass => _selectedClass;

  set selectedClass(String value) {
    _selectedClass = value;
    update();
  }

  String get selectedSubject => _selectedSubject;

  set selectedSubject(String value) {
    _selectedSubject = value;
    update();
  }

  ApiResponse getDeptOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getTeacherOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getTeacherClassOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getSectionOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getClaimOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getLeaveTypeOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getCLassOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getNationalityOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getMultipleClassSectionOptionApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getExpensesTypeApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getMultipleClassStudentOptionApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getStudOptionBasedOnClassSectionApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getExamOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getExamScoreBySubjectApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getAttendanceStatusOptionApiResponse =
      ApiResponse.initial('INITIAL');
ApiResponse getTypeReportAPiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getStatusReportAPiResponse = ApiResponse.initial('INITIAL');

  ApiResponse getGetBankAccountOptionApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getPaymentModeOptionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getStudentPendingFeesOptionApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse getTemplateOptionApiResponse  = ApiResponse.initial('INITIAL');


  void clearSectionOption() {
    getSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearAddAnnounceOption() {
    getCLassOptionApiResponse = ApiResponse.initial('INITIAL');
    getMultipleClassSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    getMultipleClassStudentOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearApplyPaymentOption() {
    getCLassOptionApiResponse = ApiResponse.initial('INITIAL');
    getMultipleClassSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    getStudOptionBasedOnClassSectionApiResponse =
        ApiResponse.initial('INITIAL');
    getGetBankAccountOptionApiResponse = ApiResponse.initial('INITIAL');
    getPaymentModeOptionApiResponse = ApiResponse.initial('INITIAL');
    getStudentPendingFeesOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearAddExamScore() {
    _selectedClass = "";
    _selectedSection = "";
    _selectedExam = "";
    _selectedExamSubject = "";
    _selectedType = "";
    examScore.clear();
    getTeacherClassOptionApiResponse = ApiResponse.initial('INITIAL');
    getSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamScoreBySubjectApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearAddExamScoreOnClassChange() {
    _selectedSection = "";
    _selectedExam = "";
    _selectedExamSubject = "";
    getSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearAddExamScoreOnSectionChange() {
    _selectedExam = "";
    _selectedExamSubject = "";
    getExamOptionApiResponse = ApiResponse.initial('INITIAL');
    getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearAddExamScoreOnExamChange() {
    _selectedExamSubject = "";
    getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearMultiClassSection() {
    getMultipleClassSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearMultiClassStud() {
    getMultipleClassSectionOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearClassOption() {
    getCLassOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearTeacherClassOption() {
    getTeacherClassOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearSubjectClassOption() {
    getSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearExamOption() {
    getExamOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  void clearExamSubjectOption() {
    getExamSubjectOptionApiResponse = ApiResponse.initial('INITIAL');
    update();
  }

  /// GET EXAM OPTION
  Future<void> getExamOption(GetExamOptionReqModel reqModel) async {
    getExamOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetExamOptionRepo().getExamOptionRepo(reqModel);
      getExamOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExamOptionApiResponse ERROR :=> $e');
      getExamOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET EXAM SUBJECT OPTION
  Future<void> getExamSubjectOption(
      GetExamSubjectOptionReqModel reqModel) async {
    getExamSubjectOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetExamSubjectOptionRepo().getExamSubjectOptionRepo(reqModel);
      getExamSubjectOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExamSubjectOptionApiResponse ERROR :=> $e');
      getExamSubjectOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET EXAM SCORE BY SUBJECT
  Future<void> getExamScoreBySubject(
      GetExamScoreBySubjectReqModel reqModel) async {
    getExamScoreBySubjectApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetExamScoreBySubjectRepo().getExamScoreBySubjectRepo(reqModel);
      getExamScoreBySubjectApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExamScoreBySubjectApiResponse ERROR :=> $e');
      getExamScoreBySubjectApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET CLAIM OPTION
  Future<void> getClaimOption() async {
    getClaimOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetClaimOptionRepo().getClaimOption();
      getClaimOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getClaimOptionApiResponse ERROR :=> $e');
      getClaimOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET DEPARTMENT OPTION
  Future<void> getDepartmentOption() async {
    getDeptOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetDepartmentOptionRepo().getDepartmentOption();
      getDeptOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getDeptOptionApiResponse ERROR :=> $e');
      getDeptOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET TEACHER OPTION
  Future<void> getTeacherOption() async {
    clearSectionOption();
    clearTeacherClassOption();
    clearSubjectClassOption();
    getTeacherOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetTeacherOptionRepo().getTeacherOption();
      getTeacherOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getTeacherOptionApiResponse ERROR :=> $e');
      getTeacherOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET TEACHER CLASS OPTION
  Future<void> getTeacherClassOption(String teacherId) async {
    clearSectionOption();
    clearSubjectClassOption();
    getTeacherClassOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetTeacherClassOptionRepo().getTeacherClassOption(teacherId);
      getTeacherClassOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getTeacherClassOptionApiResponse ERROR :=> $e');
      getTeacherClassOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET SECTION OPTION
  Future<void> getSectionOption(String classId) async {
    getSectionOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetSectionOptionRepo().getSectionOption(classId);
      getSectionOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getSectionOptionApiResponse ERROR :=> $e');
      getSectionOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET SUBJECT OPTION
  Future<void> getSubjectOption(
      {required String classId, required String teacherId}) async {
    getSubjectOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetSubjectOptionRepo()
          .getSubjectOption(classId: classId, teacherId: teacherId);
      getSubjectOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getSubjectOptionApiResponse ERROR :=> $e');
      getSubjectOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET LEAVE TYPE OPTION
  Future<void> getLeaveTypeOption() async {
    getLeaveTypeOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetLeaveTypeOptionRepo().getLeaveTypeOption();
      getLeaveTypeOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getLeaveTypeOptionApiResponse ERROR :=> $e');
      getLeaveTypeOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET CLASS OPTION
  Future<void> getClassOption() async {
    getCLassOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetClassOptionRepo().getClassOption();
      getCLassOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getCLassOptionApiResponse ERROR :=> $e');
      getCLassOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// EDIT EXPENSES STATUS SCREEN OPTION
  Future <void> getStatusOption()async{
    getStatusReportAPiResponse = ApiResponse.loading("LOADING");
    // update();
    try{
      final response = await GetEditStatusRepo().getEditStatus();
      getStatusReportAPiResponse = ApiResponse.complete(response);
    }catch(e){
      print('getEditStatusReportAPiResponse Error :==>$e');
      getStatusReportAPiResponse = ApiResponse.error('ERROR');
    }
    update();
    }

    /// GET EXPENSES TYPE SCREEN OPTION

  Future<void> getTypeOption()async{
    getTypeReportAPiResponse = ApiResponse.loading("Loading");
    // update();
    try{
      final response = await GetEditTypeRepo().getEditType();
      getTypeReportAPiResponse = ApiResponse.complete(response);
    }catch(e){
      print('getEditTypeReportAPiResponse ERROR :==>$e');
      getTypeReportAPiResponse=ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET MULTI CLASS SECTION OPTION
  Future<void> getMultiClassSectionOption(String classId) async {
    getMultipleClassSectionOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetMultiClassSectionOptionRepo()
          .getMultiClassSectionOption(classId);
      getMultipleClassSectionOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getMultipleClassSectionOptionApiResponse ERROR :=> $e');
      getMultipleClassSectionOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET MULTI CLASS STUD OPTION
  Future<void> getMultiClassStudOption(String classId) async {
    getMultipleClassStudentOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetMultiClassStudOptionRepo().getMultiClassStudOption(classId);
      getMultipleClassStudentOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getMultipleClassStudentOptionApiResponse ERROR :=> $e');
      getMultipleClassStudentOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET MULTI CLASS STUD OPTION
  Future<void> getStudBasedOnClassSectionOption({
    required String classId,
    required String sectionId,
  }) async {
    getStudOptionBasedOnClassSectionApiResponse =
        ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetStudOptionBasedOnClassSectionRepo()
          .getStudOptionBasedOnClassSection(
              sectionId: sectionId, classId: classId);
      getStudOptionBasedOnClassSectionApiResponse =
          ApiResponse.complete(response);
    } catch (e) {
      print('getStudOptionBasedOnClassSectionApiResponse ERROR :=> $e');
      getStudOptionBasedOnClassSectionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET NATIONALITY OPTION
  Future<void> getNationalityOption() async {
    getNationalityOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetNationalityOptionRepo().getNationalityOptionRepo();
      getNationalityOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getNationalityOptionApiResponse ERROR :=> $e');
      getNationalityOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET ATTENDANCE STATUS
  Future<void> getAttendanceStatus() async {
    getAttendanceStatusOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetAttendanceStatusRepo().getAttendanceStatus();
      attendanceStatusList = response.data ?? [];
      getAttendanceStatusOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getAttendanceStatusOptionApiResponse ERROR :=> $e');
      getAttendanceStatusOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET BANK ACCOUNT OPTION
  Future<void> getGetBankAccount() async {
    getGetBankAccountOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetBankAccountRepo().getBankAccount();
      getGetBankAccountOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getGetBankAccountOptionApiResponse ERROR :=> $e');
      getGetBankAccountOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET PAYMENT MODE OPTION
  Future<void> getPaymentModeOption() async {
    getPaymentModeOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetPaymentModeRepo().getPaymentMode();
      getPaymentModeOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getPaymentModeOptionApiResponse ERROR :=> $e');
      getPaymentModeOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET PAYMENT MODE OPTION
  Future<void> getStudentPendingFeesOption(String studId) async {
    getStudentPendingFeesOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetStudentPendingFeeRepo().getStudentPendingFee(studId);
      getStudentPendingFeesOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getStudentPendingFeesOptionApiResponse ERROR :=> $e');
      getStudentPendingFeesOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


  /// TEMPATE ID

  Future<void> getTemplateOption(bool isVoice) async {
    getTemplateOptionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
      await GetTemplateIdRepo().getSectionOption(isVoice);
      getTemplateOptionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getTemplateOptionApiResponse ERROR :=> $e');
      getTemplateOptionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

}
