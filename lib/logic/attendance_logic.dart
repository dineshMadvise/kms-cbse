import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_teacher_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/attendance_viewmodel.dart';

class AttendanceLogic {
  static Future<bool> saveAttendance(SaveAttendanceReqModel reqModel) async {
    AttendanceViewModel _viewModel =
        Get.find(tag: AttendanceViewModel().toString());
    reqModel.attendance = _viewModel.selectedStudent
        .map((e) => StudAttendance(status: e.attendance, studentId: e.id))
        .toList();
    await _viewModel.saveAttendance(reqModel);
    if (_viewModel.saveAttendanceApiResponse.status == Status.COMPLETE) {
      CommonResModel response = _viewModel.saveAttendanceApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        Get.back();
        _viewModel.getAttendanceList(DateTime.now());
        showToast(msg: response.data!, success: true);
        return true;
      } else {
        showToast(msg: VariableUtils.saveAttFailedMsg);
        return false;
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
      return false;
    }
  }
}
