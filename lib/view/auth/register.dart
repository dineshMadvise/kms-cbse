import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/register_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class Register extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  RegisterReqModel reqModel = RegisterReqModel();

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  SizeConfig.sH20,
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_back),
                          )),
                      Spacer(),
                      ImagesWidgets.appLogo1,
                      Spacer(),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                  SizeConfig.sH30,
                  Text(
                      VariableUtils.welcomeTOMspEduCare + ConstUtils.appVersion,
                      style: FontTextStyle.poppinsW5S12Grey),
                  SizeConfig.sH10,
                  Text(VariableUtils.signUpHere,
                      style: FontTextStyle.poppinsW7S22Black),
                  SizeConfig.sH20,
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: ImagesWidgets.loginBg),
                        formData(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<AuthViewModel>(
            tag: AuthViewModel().toString(),
            builder: (controller) {
              print('STATUS :${controller.registerApiResponse.status}');
              if (controller.registerApiResponse.status == Status.LOADING) {
                return postDataLoadingIndicator();
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }

  Widget formData() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CommonTextField(
                titleText: VariableUtils.schName,
                regularExpression: RegularExpression.addressValidationPattern,
                hintText: VariableUtils.schName,
                onChange: (value) {
                  reqModel.schName = value;
                },
                isValidate: true,
                validationMessage: ValidationMsg.isRequired,
              ),
              SizeConfig.sH5,
              CommonTextField(
                titleText: VariableUtils.contactPersonName,
                regularExpression: RegularExpression.addressValidationPattern,
                hintText: VariableUtils.contactPersonName,
                onChange: (value) {
                  reqModel.contactName = value;
                },
                isValidate: true,
                validationMessage: ValidationMsg.isRequired,
              ),
              SizeConfig.sH5,
              CommonTextField(
                titleText: VariableUtils.pNumber,
                regularExpression: RegularExpression.digitsPattern,
                hintText: VariableUtils.pNumber,
                onChange: (value) {
                  reqModel.pNUmber = value;
                },
                isValidate: true,
                validationMessage: ValidationMsg.isRequired,
                validationType: ValidationType.PNumber,
                textInputType: TextInputType.phone,
              ),
              SizeConfig.sH5,
              CommonTextField(
                titleText: VariableUtils.emailId,
                textInputType: TextInputType.emailAddress,
                regularExpression: RegularExpression.emailPattern,
                hintText: VariableUtils.emailId,
                onChange: (value) {
                  reqModel.email = value;
                },
                isValidate: true,
                validationMessage: ValidationMsg.isRequired,
              ),
              SizeConfig.sH20,
              CustomBtn(
                bgColor: ColorUtils.blue,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    final status = await LoginLogic.register(reqModel);
                    if (status) {
                      formKey.currentState!.reset();
                      Get.focusScope!.unfocus();
                      await Future.delayed(Duration(seconds: 2));
                      Get.back();
                    }
                  }
                },
                radius: 10,
                title: VariableUtils.signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
