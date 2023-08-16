import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/custom_appbar.dart';
import 'package:msp_educare_demo/common/commonMethods/get_file_picker.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_datetime_textfield.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/profile_image_circle.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_staff_profile_req_model.dart';
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

class StaffDetailScreen extends StatelessWidget {
  StaffDetailScreen({Key? key}) : super(key: key);

  final authViewModel =
      Get.find<AuthViewModel>(tag: AuthViewModel().toString());

  RxBool isEdit = false.obs;
  UpdateStaffProfileReqModel reqModel = UpdateStaffProfileReqModel();

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
              authViewModel.updateTeacherProfileApiResponse = ApiResponse.initial('INITIAL');
            });
          },
          builder: (con) {
            if (con.teacherDetailApiResponse.status == Status.LOADING ||
                con.teacherDetailApiResponse.status == Status.INITIAL) {
              return getDataLoadingIndicator();
            }
            if (con.teacherDetailApiResponse.status == Status.ERROR) {
              return getDataErrorMsg();
            }
            TeacherDetailResModel model = con.teacherDetailApiResponse.data;
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
                      ProfileImageCircle(profilePic: detail.profileImage ?? ""),
                      SizeConfig.sH20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() => AbsorbPointer(
                              absorbing: !isEdit.value,
                              child: Column(
                                children: [
                                  fNameTextField(detail),
                                  lNameTextField(detail),
                                  bloodGroupTextField(detail),
                                  dob(detail),
                                  SizeConfig.sH20,
                                  phoneNumberTextField(detail),
                                  SizeConfig.sH5,
                                  emailTextField(detail),
                                  SizeConfig.sH5,
                                  password(detail),
                                  if (isEdit.value)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: CustomBtn(
                                        onTap: (){
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
                if(con.updateTeacherProfileApiResponse.status==Status.LOADING)
                  postDataLoadingIndicator(),
              ],
            );
          },
        ));
  }

  void _updateBtnOnTap(TeacherData detail){

    reqModel.userId=ConstUtils.getUserData().userid;
    reqModel.firstName=reqModel.firstName??detail.firstName;
    reqModel.lastName=reqModel.lastName??detail.lastName;
    reqModel.dob=reqModel.dob??detail.dob;
    reqModel.bloodGroup=reqModel.bloodGroup??detail.bloodGroup;
    reqModel.phoneNo=reqModel.phoneNo??detail.phonenumber;
    reqModel.mailid=reqModel.mailid??detail.mailid;
    reqModel.password=reqModel.password??detail.password;
    reqModel.confirmPassword=reqModel.password??detail.password;
    LoginLogic.updateStaffProfile(reqModel);
  }

  /// ================== FIRST NAME TEXT FIELD ==================== ///
  CommonTextField fNameTextField(TeacherData detail) {
    return CommonTextField(
      titleText: VariableUtils.fName,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.fName,
      initialValue: detail.firstName!,
      isValidate: true,
      onChange: (str){
        reqModel.firstName=str;
      },
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== LAST NAME TEXT FIELD ==================== ///
  CommonTextField lNameTextField(TeacherData detail) {
    return CommonTextField(
      titleText: VariableUtils.lName,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.lName,
      initialValue: detail.lastName!,
      isValidate: true,
      onChange: (str){
        reqModel.lastName=str;
      },
      validationMessage: ValidationMsg.isRequired,
    );
  }


  /// ================== BLOOD GROUP TEXT FIELD ==================== ///
  CommonTextField bloodGroupTextField(TeacherData detail) {
    return CommonTextField(
      titleText: VariableUtils.bloodGroup,
      regularExpression: RegularExpression.addressValidationPattern,
      hintText: VariableUtils.empty,
      initialValue: detail.bloodGroup,
      onChange: (value) {
        reqModel.bloodGroup=value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== PASSWORD TEXT FIELD ==================== ///


  Widget password(TeacherData detail){
    return  CommonTextField(
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

  CustomDateTimeTextField dob(TeacherData detail) {
    return CustomDateTimeTextField(
      titleText: VariableUtils.dob,
      initialValue: detail.dob == null || detail.dob == ""
          ? null
          : DateTime.parse(detail.dob!),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      onChangeDateTime: (value) {
        print('DATE :$value');
        reqModel.dob=DateFormatUtils.yyyyMMDDFormat(value);
      },
    );
  }

  /// ================== PHONE NUMBER TEXT FIELD ==================== ///
  CommonTextField phoneNumberTextField(TeacherData detail) {
    return CommonTextField(
      titleText: VariableUtils.phoneNumber,
      regularExpression: RegularExpression.digitsPattern,
      hintText: VariableUtils.phoneNumber,
      initialValue: detail.phonenumber,
      textInputType: TextInputType.phone,
      onChange: (str){
        reqModel.phoneNo=str;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  /// ================== EMAIL TEXT FIELD ==================== ///
  CommonTextField emailTextField(TeacherData detail) {
    return CommonTextField(
      titleText: VariableUtils.email,
      regularExpression: RegularExpression.emailValidationPattern,
      hintText: VariableUtils.email,
      initialValue: detail.mailid,
      onChange: (str){
        reqModel.mailid=str;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }
}
