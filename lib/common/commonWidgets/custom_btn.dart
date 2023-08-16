/// KEY : customBtn
/// Desc. : Add Custom Button
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart' as tpdf;

class CustomBtn extends StatelessWidget {
  final tpdf.OnTap? onTap;
  final String? title;
  final double? radius;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? borderColor;
  final double? fontSize;
  final bool? isDownloadFile;
  final IconData? leading;

  // ignore: use_key_in_widget_constructors
  const CustomBtn(
      {required this.onTap,
      required this.title,
      this.radius,
      this.borderColor,
      this.height,
      this.width,
      this.fontSize,
      this.bgColor,
      this.leading,
      this.isDownloadFile = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.transparent,
      child: Ink(
        height: height ?? 50,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: bgColor ?? ColorUtils.transparent,
          border: Border.all(color: borderColor ?? ColorUtils.blue),
          borderRadius: BorderRadius.circular(radius ?? 25),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius ?? 25),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      leading!,
                      color: ColorUtils.white,
                    ),
                  ),
                Text(
                  title!,
                  style: bgColor == null
                      ? FontTextStyle.poppinsW6S14Purple
                          .copyWith(color: ColorUtils.blue)
                      : FontTextStyle.poppinsW6S14white,
                ),
                if (isDownloadFile!)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: const Icon(
                      ConstUtils.kDownloadIcon,
                      color: ColorUtils.blue,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
