import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/profile_image_circle.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_student_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/student_detail_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/staff_detail_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class StudentDetailScreen extends StatelessWidget {
  StudentDetailScreen({Key? key}) : super(key: key);

  final authViewModel =
      Get.find<AuthViewModel>(tag: AuthViewModel().toString());

  RxBool isEdit = false.obs;
  UpdateStudentProfileReqModel reqModel = UpdateStudentProfileReqModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: VariableUtils.detail,
          actionVisible: true,
          action: Obx(() => isEdit.value
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    isEdit.value = true;
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: ColorUtils.black,
                  )))),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SizedBox(
        height: Get.height,
        width: Get.width,
        child: GetBuilder<AuthViewModel>(
          tag: AuthViewModel().toString(),
          initState: (_) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              authViewModel.selectedProfilePick = "";
              authViewModel.updateStudentProfileApiResponse =
                  ApiResponse.initial('INITIAL');
            });
          },
          builder: (con) {
            if (con.studentDetailApiResponse.status == Status.LOADING ||
                con.studentDetailApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (con.studentDetailApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            StudentDetailResModel model = con.studentDetailApiResponse.data;
            if (model.status != VariableUtils.ok ||
                (model.data?.isEmpty ?? true) == true) {
              return getFieldIsEmptyMsg();
            }

            final detail = model.data!.first;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileImageCircle(
                        profilePic: detail.profileImage ?? "",
                        isStudent: true,
                      ),
                      SizeConfig.sH20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() => AbsorbPointer(
                              absorbing: !isEdit.value,
                              child: Column(
                                children: [
                                  studIdTextField(detail),
                                  SizeConfig.sH5,
                                  nameTextField(detail),
                                  SizeConfig.sH5,
                                  classAndSectionTextField(detail),
                                  SizeConfig.sH5,
                                  bloodGroupTextField(detail),
                                  dob(detail),
                                  SizeConfig.sH20,
                                  fatherNameTextField(detail),
                                  SizeConfig.sH5,
                                  phoneNumberTextField(detail),
                                  SizeConfig.sH5,
                                  emailTextField(detail),
                                  SizeConfig.sH5,
                                  password(detail),
                                  if (isEdit.value)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: CustomBtn(
                                        onTap: () {
                                          _updateBtnOnTap(detail);
                                        },
                                        radius: 10,
                                        title: VariableUtils.update,
                                      ),
                                    ),
                                  SizeConfig.sH20,
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                if (con.updateStudentProfileApiResponse.status ==
                    Status.LOADING)
                  postDataLoadingIndicator(),
              ],
            );
          },
        ));
  }

  void _updateBtnOnTap(StudentDetailData detail) {
    reqModel.userId = ConstUtils.getStudentData().id;
    reqModel.name = reqModel.name ?? detail.name;
    reqModel.dob = reqModel.dob ?? detail.dob;
    reqModel.bloodGroup = reqModel.bloodGroup ?? detail.bloodGroup;
    reqModel.fatherPhonenumber =
        reqModel.fatherPhonenumber ?? detail.fatherPhonenumber;
    reqModel.fatherMailid = reqModel.fatherMailid ?? detail.fatherMailid;
    reqModel.password = reqModel.password ?? detail.password;
    reqModel.confirmPassword = reqModel.password ?? detail.password;
    LoginLogic.updateStudentProfile(reqModel);
  }

  /// ================== NAME TEXT FIELD ==================== ///
  CommonTextField studIdTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.studentIdStr,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.empty,
      initialValue: detail.studentId,
      readOnly: true,
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== NAME TEXT FIELD ==================== ///
  CommonTextField nameTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.nameStr,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.nameStr,
      initialValue: detail.name,
      isValidate: true,
      onChange: (str) {
        reqModel.name = str;
      },
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== CLASS AND SECTION TEXT FIELD ==================== ///
  CommonTextField classAndSectionTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.classAndSection,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.empty,
      initialValue: detail.className! + "  " + detail.sectionName!,
      readOnly: true,
      onChange: (value) {},
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== BLOOD GROUP TEXT FIELD ==================== ///
  CommonTextField bloodGroupTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.bloodGroup,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.empty,
      initialValue: detail.bloodGroup,
      onChange: (value) {
        reqModel.bloodGroup = value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== PASSWORD TEXT FIELD ==================== ///

  Widget password(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.password,
      obscureValue: true,
      initialValue: detail.password,
      regularExpression: RegularExpression.passwordPattern,
      hintText: VariableUtils.password.capitalizeFirst,
      validationType: ValidationType.Password,
      onChange: (value) {
        reqModel.password = value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== DOB TEXT FIELD ==================== ///

  CustomDateTimeTextField dob(StudentDetailData detail) {
    return CustomDateTimeTextField(
      titleText: VariableUtils.dob,
      initialValue: detail.dob == null || detail.dob == ""
          ? null
          : DateTime.parse(detail.dob!),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      onChangeDateTime: (value) {
        print('DATE :$value');
        reqModel.dob = DateFormatUtils.yyyyMMDDFormat(value);
      },
    );
  }

  /// ================== FATHER NAME TEXT FIELD ==================== ///
  CommonTextField fatherNameTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.fatherName,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.fatherName,
      initialValue: detail.fatherName,
      onChange: (str) {
        reqModel.fatherName = str;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== PHONE NUMBER TEXT FIELD ==================== ///
  CommonTextField phoneNumberTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.fatherPNumber,
      regularExpression: RegularExpression.digitsPattern,
      hintText: VariableUtils.fatherPNumber,
      initialValue: detail.fatherPhonenumber,
      textInputType: TextInputType.phone,
      onChange: (str) {
        reqModel.fatherPhonenumber = str;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== EMAIL TEXT FIELD ==================== ///
  CommonTextField emailTextField(StudentDetailData detail) {
    return CommonTextField(
      titleText: VariableUtils.fatherEmail,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.fatherEmail,
      initialValue: detail.fatherMailid,
      onChange: (str) {
        reqModel.fatherMailid = str;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }
}
