/// KEY : customTextField
/// Desc. : Add Custom Custom TextField
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class CommonTextField extends StatelessWidget {
  final String? titleText;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? textInputType;
  final ValidationType? validationType;
  final String? regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final int maxLine;
  final Widget? sIcon;
  final bool? obscureValue;
  final OnChangeString? onChange;
  final OnChangeString? onFieldSubmitted;

  const CommonTextField(
      {Key? key, required this.titleText,
      this.isValidate,
      this.textInputType,
      this.validationType,
      required this.regularExpression,
      this.inputLength,
      this.readOnly = false,
      this.hintText,
      this.validationMessage,
      this.maxLine = 1,
      this.sIcon,
      this.onChange,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.obscureValue}) : super(key: key);

  /// PLEASE IMPORT GETX PACKAGE
  @override
  Widget build(BuildContext context) {
    print('isValidate=$isValidate NAME=>$titleText');
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            titleText == VariableUtils.remark
                ? titleText!.capitalizeFirst!
                : titleText!.toUpperCase(),
            style: FontTextStyle.poppinsW6S12Grey),
        if (titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 5,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            initialValue: initialValue,
            inputFormatters:
                regularExpression == RegularExpression.addressValidationPattern
                    ? []
                    : [
                        LengthLimitingTextInputFormatter(inputLength),
                        FilteringTextInputFormatter.allow(
                            RegExp(regularExpression!))
                      ],
            obscureText: validationType == ValidationType.Password
                ? obscureValue!
                : false,
            onChanged: onChange,
            onFieldSubmitted: onFieldSubmitted,
            enabled: !readOnly!,
            readOnly: readOnly!,
            validator: (value) {

              return isValidate == false
                  ? null
                  : value!.isEmpty
                      ? validationMessage
                      : validationType == ValidationType.Email
                          ? ValidationMethod.validateUserName(value)
                          : validationType == ValidationType.PNumber
                              ? ValidationMethod.validatePhoneNo(value)
                              : null;
            },
            style: FontTextStyle.poppinsW4S16Black,
            keyboardType:
                maxLine > 1 ? TextInputType.multiline : TextInputType.text,
            textInputAction:
                maxLine > 1 ? TextInputAction.newline : TextInputAction.done,
            maxLines: maxLine,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: Get.height * 0.018,
                  bottom: Get.height * 0.018,
                  left: 15,
                ),
                focusedBorder: DecorationUtils.outLinePurpleR8,
                enabledBorder: DecorationUtils.outLineGeryR8,
                disabledBorder: DecorationUtils.outLineGeryR8,
                errorBorder: DecorationUtils.outLineRedR8,
                focusedErrorBorder: DecorationUtils.outLineRedR8,
                filled: true,
                suffixIconConstraints:
                    const BoxConstraints(maxWidth: 40, maxHeight: 40),
                suffixIcon: sIcon ?? const SizedBox(),
                fillColor: ColorUtils.white,
                hintStyle: FontTextStyle.poppinsW5S12Grey,
                hintText: hintText),
          ),
        ),
        if (titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
      ],
    );
  }
}

/*
/// KEY : customTextField
/// Desc. : Add Custom Custom TextField
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class CommonTextField extends StatelessWidget {
  final String? titleText;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? textInputType;
  final ValidationType? validationType;
  final String? regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final int? maxLine;
  final Widget? sIcon;
  final bool? obscureValue;
  final OnChangeString? onChange;
  final OnChangeString? onFieldSubmitted;

  const CommonTextField(
      {required this.titleText,
      this.isValidate,
      this.textInputType,
      this.validationType,
      required this.regularExpression,
      this.inputLength,
      this.readOnly = false,
      this.hintText,
      this.validationMessage,
      this.maxLine,
      this.sIcon,
      this.onChange,
      this.onFieldSubmitted,
      this.initialValue = '',
      this.obscureValue});

  /// PLEASE IMPORT GETX PACKAGE
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            titleText == VariableUtils.remark
                ? titleText!.capitalizeFirst!
                : titleText!.toUpperCase(),
            style: FontTextStyle.poppinsW6S12Grey),
        if (titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 5,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            keyboardType: textInputType ?? TextInputType.text,
            maxLines: maxLine ?? 1,
            initialValue: initialValue,
            inputFormatters:
                regularExpression == RegularExpression.addressValidationPattern
                    ? []
                    : [
                        LengthLimitingTextInputFormatter(inputLength),
                        FilteringTextInputFormatter.allow(
                            RegExp(regularExpression!))
                      ],
            obscureText: validationType == ValidationType.Password
                ? obscureValue!
                : false,
            onChanged: onChange,
            onFieldSubmitted: onFieldSubmitted,
            enabled: !readOnly!,
            readOnly: readOnly!,
            validator: (value) {

              return isValidate == false
                  ? null
                  : value!.isEmpty
                      ? validationMessage
                      : validationType == ValidationType.Email
                          ? ValidationMethod.validateUserName(value)
                          : validationType == ValidationType.PNumber
                              ? ValidationMethod.validatePhoneNo(value)
                              : null;
            },
            style: FontTextStyle.poppinsW4S16Black,
            textInputAction:
                maxLine == 4 ? TextInputAction.none : TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: Get.height * 0.018,
                  bottom: Get.height * 0.018,
                  left: 15,
                ),
                focusedBorder: DecorationUtils.outLinePurpleR8,
                enabledBorder: DecorationUtils.outLineGeryR8,
                disabledBorder: DecorationUtils.outLineGeryR8,
                errorBorder: DecorationUtils.outLineRedR8,
                focusedErrorBorder: DecorationUtils.outLineRedR8,
                // isDense: true,
                // isCollapsed: true,
                filled: true,
                suffixIconConstraints:
                    BoxConstraints(maxWidth: 40, maxHeight: 40),
                suffixIcon: sIcon ?? SizedBox(),
                fillColor: ColorUtils.white,
                hintStyle: FontTextStyle.poppinsW5S12Grey,
                hintText: hintText

                // labelStyle: FontTextStyle.robotoW7S17Black),
                // labelText: labelText,
                ),
          ),
        ),
        if (titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
      ],
    );
  }
}
*/
