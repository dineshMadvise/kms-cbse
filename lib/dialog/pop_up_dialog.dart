import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_btn.dart';
import 'package:msp_educare_demo/common/commonWidgets/octo_image_network.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_popup_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/pop_up_viewmodel.dart';

Future<void> showPopUp() async {
  final _popUpViewModel =
      Get.find<PopUpViewModel>(tag: PopUpViewModel().toString());
  await _popUpViewModel.getPopUp();
  if (_popUpViewModel.getPopUpApiResponse.status == Status.COMPLETE) {
    GetPopupResModel result = _popUpViewModel.getPopUpApiResponse.data;
    if (result.data?.isNotEmpty == true) {
      Get.dialog(
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizeConfig.sH5,
                OctoImageNetwork(
                  url: '${result.data?.first.image}',
                  circleShape: false,
                  height: Get.height * 0.17,
                  width: Get.width,
                  fit: true,
                ),
                SizeConfig.sH20,
                Text(
                  result.data?.first.title ?? VariableUtils.none,
                  style: FontTextStyle.poppinsW6S18Black,
                ),
                SizeConfig.sH10,
                Html(data: result.data?.first.description),
                SizeConfig.sH10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
                  child: CustomBtn(
                    onTap: () {
                      _popUpViewModel.postReadPopUp(result.data!.first.id!);
                      Get.back();
                    },
                    title: VariableUtils.gotId,
                    bgColor: ColorUtils.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
