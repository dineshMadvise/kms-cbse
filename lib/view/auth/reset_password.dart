import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonMethods/toast_msg.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/reset_pass_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class ResetPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  ResetPasswordReqModel _reqModel = ResetPasswordReqModel();

  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Scaffold buildBody(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ImagesWidgets.loginBg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizeConfig.sH20,
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back)),
                      const Spacer(),
                      ImagesWidgets.appLogo2,
                      const Spacer(),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizeConfig.sH30,
                  Text(
                      VariableUtils.welcomeTOMspEduCare + ConstUtils.appVersion,
                      style: FontTextStyle.poppinsW5S12Grey),
                  SizeConfig.sH10,
                  formData()
                ],
              ),
              GetBuilder<AuthViewModel>(
                tag: AuthViewModel().toString(),
                builder: (controller) {
                  if (controller.resetPasswordApiResponse.status ==
                      Status.LOADING) {
                    return postDataLoadingIndicator();
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded formData() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.sH20,
                otpTextField(),
                SizeConfig.sH5,
                passTextField(),
                SizeConfig.sH20,
                confirmPassTextField(),
                SizeConfig.sH20,
                CustomBtn(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (newPassword != _reqModel.password) {
                        showToast(
                            msg: VariableUtils.passAndConfirmPassNotMatch);
                        return;
                      }
                      LoginLogic.resetPassword(_reqModel);
                    }
                  },
                  title: VariableUtils.reset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CommonTextField confirmPassTextField() {
    return CommonTextField(
      titleText: VariableUtils.confirmPassword,
      regularExpression: RegularExpression.passwordPattern,
      hintText: VariableUtils.password.capitalizeFirst,
      // validationType: ValidationType.Password,
      onChange: (value) {
        // reqModel.password = value;
        _reqModel.password = value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  CommonTextField passTextField() {
    return CommonTextField(
      titleText: VariableUtils.newPassword,
      regularExpression: RegularExpression.passwordPattern,
      hintText: VariableUtils.password.capitalizeFirst,
      // validationType: ValidationType.Password,

      onChange: (value) {
        newPassword = value;
      },

      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  Widget otpTextField() {
    return CommonTextField(
      titleText: VariableUtils.otp,
      textInputType: TextInputType.number,
      regularExpression: RegularExpression.digitsPattern,
      onChange: (value) {
        _reqModel.otp = value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }
}
