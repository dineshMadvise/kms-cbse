import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import 'package:msp_educare_demo/viewModel/auth_viewmodel.dart';

import 'octo_image_network.dart';

class SmallUserProfileBox extends StatelessWidget {
  final bool? isLarge;

  SmallUserProfileBox({
    Key? key,
    this.isLarge = false,
  }) : super(key: key);
  // StudentData studentData = ConstUtils.getStudentData();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      tag: AuthViewModel().toString(),
      builder: (cont) {
        if(cont.selectedStudent==null){
          return const SizedBox();
        }
        StudentData studentData=cont.selectedStudent!;
        return Container(
          width: Get.width,
          margin: EdgeInsets.fromLTRB(20, isLarge! ? 0 : 10, 20, 20),
          decoration: DecorationUtils.commonDecorationBox(color: ColorUtils.blue),
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: isLarge! ? 15 : 10),
          child: Row(
            children: [
              // ClipOval(
              //   child: CircleAvatar(
              //     radius: isLarge! ? 28 : 25,
              //     backgroundColor: ColorUtils.lightPurple,
              //     child: ImagesWidgets.eventPersonIcon,
              //   ),
              // ),

              if (studentData.profile != null)
                ClipOval(
                  child: OctoImageNetwork(
                    url: studentData.profile,
                    radius: isLarge! ? 28 : 25,
                    width: isLarge! ? 56 : 50,
                    height: isLarge! ? 56 : 50,
                  ),
                ),

              /// have some error at this point
              SizeConfig.sW10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      studentData.name ?? '/N/A',
                      style: FontTextStyle.poppinsW6S12White,
                    ),
                    isLarge! ? SizeConfig.sH10 : SizeConfig.sH5,
                    Container(
                      decoration: DecorationUtils.borderDecorationBox(
                          radius: 30, color: ColorUtils.white),
                      margin:
                          isLarge! ? const EdgeInsets.only(right: 30) : EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "${studentData.className} ${studentData.sectionName}",
                          style: FontTextStyle.poppinsW5S12White,
                        ),
                      ),
                    ),
                    if (isLarge!)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '${VariableUtils.studentId} ${studentData.studentId}',
                          style: FontTextStyle.poppinsW6S12White,
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
