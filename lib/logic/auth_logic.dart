import 'dart:convert';

import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/login_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/register_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/reset_pass_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/send_otp_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_staff_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_student_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_school_logo_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/send_otp_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';
import 'package:msp_educare_demo/viewModel/dashboard_viewmodel.dart';

class LoginLogic {
  static void onSignUpBtnClick() {
    RouteUtils.navigateRoute(RouteUtils.register);
  }

  static AuthViewModel authViewModel =
      Get.find(tag: AuthViewModel().toString());


  /// GET SCH LOGO

  static Future<void> getSchLogo() async {
    final authViewModel =
        Get.find<AuthViewModel>(tag: AuthViewModel().toString());
    await authViewModel.getSchoolLogo();
    if (authViewModel.getSchLogoApiResponse.status == Status.COMPLETE) {
      GetSchoolLogoResModel resModel = authViewModel.getSchLogoApiResponse.data;
      if (resModel.status == VariableUtils.ok) {
        await PreferenceManagerUtils.setSchLogo(resModel.data!.first.logo!);
      }
    }
  }

  /// LOGIN
  static Future<void> onGetInClassRoomBtnClick(LoginReqModel reqModel) async {
    final authViewModel =
        Get.find<AuthViewModel>(tag: AuthViewModel().toString());
    await authViewModel.login(reqModel);
    if (authViewModel.loginApiResponse.status == Status.COMPLETE) {
      LoginResModel response = authViewModel.loginApiResponse.data;

      if (response.data != null) {
        await PreferenceManagerUtils.setUserData(jsonEncode(response.data));

        print('USER DATA : ${PreferenceManagerUtils.getUserData()}');
        Get.find<DashBoardViewModel>(tag: DashBoardViewModel().toString())
                .dashBoardHomeRoute =
            reqModel.userType == LoginType.Parent.index.toString()
                ? DashBoardHomeRoute.StudentList.index
                : DashBoardHomeRoute.HomeTab.index;
        RouteUtils.navigateRoute(RouteUtils.dashboard);
      } else {
        showToast(msg: VariableUtils.getInClassroomFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// LOGOUT
  static Future<void> logOutClick() async {
    final authViewModel = Get.put<AuthViewModel>(AuthViewModel(),
        tag: AuthViewModel().toString());
    await authViewModel.logout();
    if (authViewModel.logoutApiResponse.status == Status.COMPLETE) {
      Map<String, dynamic> response = authViewModel.logoutApiResponse.data;
      print('RESPONS :$response');
      if (response['status'] == VariableUtils.ok) {
        // final _dashBoardViewModel = Get.put<DashBoardViewModel>(DashBoardViewModel(),
        //     tag: DashBoardViewModel().toString());
        final _dashBoardViewModel =
            Get.find<DashBoardViewModel>(tag: DashBoardViewModel().toString());
        await _dashBoardViewModel.updateUserStatus(
            status: VariableUtils.logout);
        await PreferenceManagerUtils.setUserData('');
        await PreferenceManagerUtils.setStudData("");
        authViewModel.setSelectedStudent(null);
        RouteUtils.navigateRoute(RouteUtils.loginHere);
      } else {
        showToast(msg: VariableUtils.logoutFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// REGISTER
  static Future<bool> register(RegisterReqModel reqModel) async {
    final authViewModel =
        Get.find<AuthViewModel>(tag: AuthViewModel().toString());
    await authViewModel.register(reqModel);
    if (authViewModel.registerApiResponse.status == Status.COMPLETE) {
      Map<String, dynamic> response = authViewModel.registerApiResponse.data;
      print('RESPONS :$response');
      if (response['status'] == VariableUtils.ok) {
        showToast(msg: response['msg'], success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.loginFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }

  /// SEND OTP
  static Future<void> sendOtp(SendOtpReqModel reqModel) async {
    final authViewModel =
        Get.find<AuthViewModel>(tag: AuthViewModel().toString());
    await authViewModel.sendOtp(reqModel);
    if (authViewModel.sendOtpApiResponse.status == Status.COMPLETE) {
      SendOtpResModel response = authViewModel.sendOtpApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(msg: response.data!, success: true);
        await Future.delayed(Duration(seconds: 2));
        ResetPasswordReqModel _reqModel = ResetPasswordReqModel();
        _reqModel.userType = reqModel.userType;
        _reqModel.userId = response.userId;
        RouteUtils.navigateRoute(RouteUtils.resetPassword);
      } else {
        showToast(msg: response.data!);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// RESET PASS
  static Future<void> resetPassword(ResetPasswordReqModel reqModel) async {
    final authViewModel =
        Get.find<AuthViewModel>(tag: AuthViewModel().toString());
    await authViewModel.resetPassword(reqModel);
    if (authViewModel.resetPasswordApiResponse.status == Status.COMPLETE) {
      SendOtpResModel response = authViewModel.resetPasswordApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(msg: response.data!, success: true);
        await Future.delayed(Duration(seconds: 2));
        RouteUtils.navigateRoute(RouteUtils.loginHere);
      } else {
        showToast(msg: response.data!);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// UPDATE STAFF PROFILE
  static Future<void> updateStaffProfile(
      UpdateStaffProfileReqModel reqModel) async {
    await authViewModel.updateStaffProfile(reqModel);
    if (authViewModel.updateTeacherProfileApiResponse.status ==
        Status.COMPLETE) {
      CommonResModel response =
          authViewModel.updateTeacherProfileApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        authViewModel.teacherDetail(reqModel.userId ?? "");
        showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: response.data!);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }

  /// UPDATE STUDENT PROFILE
  static Future<void> updateStudentProfile(
      UpdateStudentProfileReqModel reqModel) async {
    await authViewModel.updateStudentProfile(reqModel);
    if (authViewModel.updateStudentProfileApiResponse.status ==
        Status.COMPLETE) {
      CommonResModel response =
          authViewModel.updateStudentProfileApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        authViewModel.studentDetail(reqModel.userId ?? "", isRefresh: true);
        showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: response.data!);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }
}
