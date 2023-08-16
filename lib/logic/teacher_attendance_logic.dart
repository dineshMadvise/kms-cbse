import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_teacher_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/teacher_viewmodel.dart';

class TeacherAttendanceLogic {
  static Future<void> saveTeacherAttendance() async {
    TeacherAttendanceViewModel _viewModel =
        Get.find(tag: TeacherAttendanceViewModel().toString());
    if (_viewModel.selectedTeacher.isEmpty) {
      return;
    }


    SaveTeacherAttendanceReqModel _reqModel = SaveTeacherAttendanceReqModel();

    _reqModel.attendance=_viewModel.selectedTeacher.map((e) => Attendance(status: e.attendance,staffId: e.id)).toList();
    _reqModel.aDate = DateFormatUtils.yyyyMMDDFormat(_viewModel.selectedDate);
    await _viewModel.saveTeacherAttendance(_reqModel);
    if (_viewModel.saveTeacherAttendanceApiResponse.status == Status.COMPLETE) {
      CommonResModel response =
          _viewModel.saveTeacherAttendanceApiResponse.data;
      print('RESPONS :$response');
      if (response.status == VariableUtils.ok) {
        showToast(msg: response.data!, success: true);
      } else {
        showToast(msg: VariableUtils.saveAttFailedMsg);
      }
    } else {
      showToast(msg: VariableUtils.somethingWantWrong);
    }
  }
}
