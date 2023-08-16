import 'package:flutter/material.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class CheckedIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: ColorUtils.lightGreen2,
      child: const Icon(
        ConstUtils.kCheckIcon,
        color: ColorUtils.green,
        size: 20,
      ),
    );
  }
}
