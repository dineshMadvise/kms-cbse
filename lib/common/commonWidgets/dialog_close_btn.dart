import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class DialogCloseBtn extends StatelessWidget {
  const DialogCloseBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: CircleAvatar(
        backgroundColor: ColorUtils.lightGrey2.withOpacity(0.2),
        child: Icon(
          ConstUtils.kClearIcon,
          color: ColorUtils.grey,
          size: 20,
        ),
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
