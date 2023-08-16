// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/send_otp_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class SendOtpScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  RxString selectedRole = VariableUtils.teacher.obs;
  SendOtpReqModel _reqModel = SendOtpReqModel();

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
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
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
                        VariableUtils.welcomeTOMspEduCare +
                            ConstUtils.appVersion,
                        style: FontTextStyle.poppinsW5S12Grey),
                    SizeConfig.sH10,
                    formData()
                    // if (MediaQuery.of(context).viewInsets.bottom == 0.0)
                    //   ImagesWidgets.loginBg
                  ],
                ),
              ),
              GetBuilder<AuthViewModel>(
                tag: AuthViewModel().toString(),
                builder: (controller) {
                  print('STATUS : => ${controller.sendOtpApiResponse.status}');
                  if (controller.sendOtpApiResponse.status == Status.LOADING) {
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

  Widget formData() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeConfig.sH20,
            Text(
              VariableUtils.myRole,
              style: FontTextStyle.poppinsW5S12Grey,
            ),
            SizeConfig.sH10,
            roleList(),
            SizeConfig.sH20,
            userIdTextField(),
            SizeConfig.sH5,
            CustomBtn(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  _reqModel.userType =
                      ConstUtils.kGetRoleIndex(selectedRole.value);
                  LoginLogic.sendOtp(_reqModel);
                }
              },
              title: VariableUtils.sendOtp,
            ),
          ],
        ),
      ),
    );
  }

  Widget userIdTextField() {
    return CommonTextField(
      titleText: VariableUtils.userId,
      regularExpression: RegularExpression.addressValidationPattern,
      onChange: (value) {
        _reqModel.userName = value;
      },
      isValidate: true,
      validationMessage: ValidationMsg.isRequired,
    );
  }

  Obx roleList() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ConstUtils.kRoleList
              .map((e) => Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        formKey.currentState!.reset();
                        selectedRole.value = e;
                      },
                      borderRadius: BorderRadius.circular(3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                            height: 40,
                            // width: 110,
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: e == VariableUtils.parent ? 10 : 0),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: selectedRole.value == e
                                ? DecorationUtils.borderDecorationBox()
                                : DecorationUtils.borderDecorationBox(
                                    color: ColorUtils.lightGrey2),
                            child: Center(
                                child: Text(
                              e,
                              style: selectedRole.value == e
                                  ? FontTextStyle.poppinsW7S14Blue
                                  : FontTextStyle.poppinsW5S14Grey,
                            ))),
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
