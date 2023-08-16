import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/checked_icon.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/dialog/update_version_dialog.dart';
import 'package:msp_educare_demo/logic/auth_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/login_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/extension_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/route_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

class LoginHere extends StatefulWidget {
  @override
  State<LoginHere> createState() => _LoginHereState();
}

class _LoginHereState extends State<LoginHere> {
  RxString selectedRole = VariableUtils.teacher.obs;

  // RxInt selectedRoleIndex = 0.obs ;
  RxBool isSuffixIconVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  LoginReqModel reqModel = LoginReqModel();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // AuthServices.setAppVersion();
      checkAppVersion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Scaffold buildBody(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
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
                      children: [
                        SizeConfig.sH10,
                        ImagesWidgets.appLogo,

                        SizeConfig.sH10,
                        Text(
                            VariableUtils.welcomeTOMspEduCare +
                                ConstUtils.appVersion,
                            style: FontTextStyle.poppinsW5S12Grey),
                        SizeConfig.sH10,
                        Text(VariableUtils.loginHere,
                            style: FontTextStyle.poppinsW9S25Black),
                        formData(),
                        // if (MediaQuery.of(context).viewInsets.bottom == 0.0)
                        //   ImagesWidgets.loginBg
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
              if (controller.loginApiResponse.status == Status.LOADING) {
                return postDataLoadingIndicator();
              }
              return const SizedBox();
            },
          )
        ],
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
            CommonTextField(
              titleText: VariableUtils.password,
              obscureValue: true,
              regularExpression: RegularExpression.passwordPattern,
              hintText: VariableUtils.password.capitalizeFirst,
              validationType: ValidationType.Password,
              onChange: (value) {
                reqModel.password = value;
              },
              onFieldSubmitted: (value) {
                reqModel.userType =
                    ConstUtils.kGetRoleIndex(selectedRole.value);
                LoginLogic.onGetInClassRoomBtnClick(reqModel);
              },
              isValidate: true,
              validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH20,
            CustomBtn(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  reqModel.userType =
                      ConstUtils.kGetRoleIndex(selectedRole.value);
                  LoginLogic.onGetInClassRoomBtnClick(reqModel);
                }
              },
              title: VariableUtils.getInClassRoom,
              bgColor: ColorUtils.blue,
            ),
            SizeConfig.sH10,
            CustomBtn(
              onTap: () {
                RouteUtils.navigateRoute(RouteUtils.newAdmissionInquiry);
              },
              title: VariableUtils.newAdmissionInquiry,
            ),
            SizeConfig.sH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // InkWell(
                //   onTap: () {
                //     RouteUtils.navigateRoute(RouteUtils.login);
                //   },
                //   child: Text(
                //     VariableUtils.loginToOtherSch,
                //     style: FontTextStyle.poppinsW5S14Blue,
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    RouteUtils.navigateRoute(RouteUtils.sendOtp);
                  },
                  child: Text(
                    VariableUtils.forgotPassword,
                    style: FontTextStyle.poppinsW5S14Blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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

  Obx userIdTextField() {
    return Obx(
      () => CommonTextField(
        titleText: VariableUtils.userId,
        hintText: VariableUtils.userId.capitalizeFirst,
        regularExpression: RegularExpression.addressValidationPattern,
        onChange: (value) {
          if (value.isEmpty) {
            isSuffixIconVisible.value = false;
          } else {
            isSuffixIconVisible.value = true;
          }
          reqModel.userName = value;
        },
        sIcon: isSuffixIconVisible.value

            // ignore: prefer_const_constructors
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                // ignore: prefer_const_constructors
                child: CheckedIcon(),
              )
            : null,
        isValidate: true,
        validationMessage: ValidationMsg.isRequired,
      ),
    );
  }
}
