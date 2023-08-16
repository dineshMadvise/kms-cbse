// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/login_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/register_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/reset_pass_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/send_otp_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_staff_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_student_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/detail_repo.dart';
import 'package:msp_educare_demo/model/repo/get_app_version_repo.dart';
import 'package:msp_educare_demo/model/repo/get_sch_logo_repo.dart';
import 'package:msp_educare_demo/model/repo/login_repo.dart';
import 'package:msp_educare_demo/model/repo/logout_repo.dart';
import 'package:msp_educare_demo/model/repo/register_repo.dart';
import 'package:msp_educare_demo/model/repo/reset_pass_repo.dart';
import 'package:msp_educare_demo/model/repo/send_otp_repo.dart';
import 'package:msp_educare_demo/model/repo/update_profile_repo.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

class AuthViewModel extends GetxController {
  StudentData? selectedStudent;

  void setSelectedStudent(StudentData? studentData) {
    print('studentData==>$studentData');
    selectedStudent = studentData;
    update();
  }

  /// PROFILE PICK
  String _selectedProfilePick = "";

  String get selectedProfilePick => _selectedProfilePick;

  set selectedProfilePick(String value) {
    _selectedProfilePick = value;
    update();
  }

  ApiResponse getInSchApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse loginApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse registerApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse logoutApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse sendOtpApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse resetPasswordApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getSchLogoApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getAppVersionApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse teacherDetailApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse studentDetailApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateStudentProfileApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse updateTeacherProfileApiResponse = ApiResponse.initial('INITIAL');

  /// GET APP VERSION
  Future<void> getAppVersion() async {
    getAppVersionApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetAppVersionRepo().getAppVersion();
      getAppVersionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getAppVersionApiResponse ERROR :=> $e');
      getAppVersionApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }


  /// GET SCHOOL LOGO
  Future<void> getSchoolLogo() async {
    getSchLogoApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetSchLogoRepo().getSchLogo();

      getSchLogoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getSchLogoApiResponse ERROR :=> $e');
      getSchLogoApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// REGISTER
  Future<void> register(RegisterReqModel reqModel) async {
    registerApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      Map<String, dynamic> response = await RegisterRepo().register(reqModel);
      registerApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('registerApiResponse ERROR :=> $e');
      registerApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET IN SCHOOL
  Future<void> logout() async {
    logoutApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      Map<String, dynamic> response = await LogOutRepo().logout();
      logoutApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('logoutApiResponse ERROR :=> $e');
      logoutApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// LOGIN
  Future<void> login(LoginReqModel reqModel) async {
    loginApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await LoginRepo().login(reqModel);
      loginApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('loginApiResponse ERROR :=> $e');
      loginApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SEND OTP
  Future<void> sendOtp(SendOtpReqModel reqModel) async {
    sendOtpApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SendOtpRepo().sendOtp(model: reqModel);
      sendOtpApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('sendOtpApiResponse ERROR :=> $e');
      sendOtpApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// RESET PASSWORD
  Future<void> resetPassword(ResetPasswordReqModel reqModel) async {
    resetPasswordApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ResetPassRepo().resetPass(model: reqModel);
      resetPasswordApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('resetPasswordApiResponse ERROR :=> $e');
      resetPasswordApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// TEACHER DETAIL
  Future<void> teacherDetail(String userId) async {
    teacherDetailApiResponse = ApiResponse.loading('LOADING');
    // update();
    try {
      final response = await TeacherDetailRepo().teacherDetailRepo(userId);
      teacherDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('teacherDetailApiResponse ERROR :=> $e');
      teacherDetailApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// STUDENT DETAIL
  Future<void> studentDetail(String userId, {bool isRefresh = false}) async {
    if (!isRefresh) {
      studentDetailApiResponse = ApiResponse.loading('LOADING');
      update();
    }

    try {
      final response = await StudentDetailRepo().studentDetailRepo(userId);
      studentDetailApiResponse = ApiResponse.complete(response);
      if ((response.data?.isNotEmpty ?? false) == true) {
        Map<String,dynamic> stud=response.data!.first.toJson();
        stud.addAll({'profile': stud['profile_image']});
        await PreferenceManagerUtils.setStudData(
            jsonEncode(StudentData.fromJson(stud)));
        selectedStudent=StudentData.fromJson(stud);
      }
    } catch (e) {
      print('studentDetailApiResponse ERROR :=> $e');
      studentDetailApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE STUDENT PROFILE
  Future<void> updateStudentProfile(
      UpdateStudentProfileReqModel reqModel) async {
    updateStudentProfileApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateStudentProfileRepo().updateStudentProfileRepo(reqModel);
      updateStudentProfileApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateStudentProfileApiResponse ERROR :=> $e');
      updateStudentProfileApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// UPDATE STAFF PROFILE
  Future<void> updateStaffProfile(UpdateStaffProfileReqModel reqModel) async {
    updateTeacherProfileApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await UpdateStaffProfileRepo().updateStaffProfileRepo(reqModel);
      updateTeacherProfileApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('updateTeacherProfileApiResponse ERROR :=> $e');
      updateTeacherProfileApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
