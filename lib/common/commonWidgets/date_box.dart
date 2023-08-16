import 'package:flutter/material.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/size_config_utils.dart';

class DateBox extends StatelessWidget {
  final TextStyle? textStyle;
  final String text;

  const DateBox({Key? key, this.textStyle, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorUtils.lightGrey)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 5,
            backgroundColor: ColorUtils.lightRed,
          ),
          SizeConfig.sW10,
          Text(
            text,
            style: textStyle ?? FontTextStyle.poppinsW6S13Purple,
          )
        ],
      ),
    );
  }
}
