import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonMethods/loading_indicator.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_text_field.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/logic/new_admission_inquiry_logic.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/new_admission_inquiry_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/assets/images_utils.dart';
import 'package:msp_educare_demo/utils/shared_preference_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/viewModel/new_admission_inquiry_viewmodel.dart';

class NewAdmissionInquiry extends StatelessWidget {
  NewAdmissionInquiry({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  NewAdmissionInquiryReqModel reqModel = NewAdmissionInquiryReqModel();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
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
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizeConfig.sH10,
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
                            ImagesWidgets.appLogo,
                            const Spacer(),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        SizeConfig.sH10,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              VariableUtils.newAdmissionInquiry,
                              style: FontTextStyle.poppinsW7S22Black.copyWith(
                                  color: ColorUtils.darkRed,
                                  fontWeight: FontWeightClass.semiB,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        SizeConfig.sH5, // SizeConfig.sH10,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(VariableUtils.newAdmissionInquiryNote,
                                style: FontTextStyle.poppinsW5S16Grey),
                          ),
                        ),
                        SizeConfig.sH10,
                        formData(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<NewAdmissionInquiryViewModel>(
            tag: NewAdmissionInquiryViewModel().toString(),
            builder: (controller) {
              if (controller.newAdmissionInquiryApiResponse.status ==
                  Status.LOADING) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              titleText: VariableUtils.studName,
              hintText: VariableUtils.studName.capitalizeFirst,
              regularExpression: RegularExpression.addressValidationPattern,
              onChange: (value) {
                reqModel.studName = value;
              },
              isValidate: true,
              validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH5,
            CommonTextField(
              titleText: VariableUtils.admissionClass,
              hintText: VariableUtils.admissionClass.capitalizeFirst,
              regularExpression: RegularExpression.addressValidationPattern,
              onChange: (value) {
                reqModel.admissionClass = value;
              },
              isValidate: true,
              validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH5,
            CommonTextField(
              titleText: VariableUtils.parentMobileNumber,
              hintText: VariableUtils.parentMobileNumber.capitalizeFirst,
              regularExpression: RegularExpression.digitsPattern,
              textInputType: TextInputType.phone,
              onChange: (value) {
                reqModel.parentMobileNo = value;
              },
              isValidate: true,
              validationMessage: ValidationMsg.isRequired,
            ),
            SizeConfig.sH20,
            CustomBtn(
              onTap: onSaveTap,
              title: VariableUtils.save,
            ),
            SizeConfig.sH20,
          ],
        ),
      ),
    );
  }

  void onSaveTap() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final status =
          await NewAdmissionInquiryLogic.addNewAdmissionInquiry(reqModel);
      if (status == true) {
        formKey.currentState!.reset();
      }
    }
  }
}
