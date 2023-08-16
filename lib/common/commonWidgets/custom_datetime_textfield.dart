import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';

class CustomDateTimeTextField extends StatelessWidget {
  final String titleText;
  final DateTime? initialValue;
  final DateTime? initialDateShowPicker;

  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool? isValidate;
  final bool isTitleVisible;
  final String? hintText;
  final String? dateFormat;

  final OnChangeDateTime? onChangeDateTime;

  const CustomDateTimeTextField(
      {Key? key,
      required this.titleText,
      this.onChangeDateTime,
      this.initialValue,
      this.firstDate,
      this.isValidate = false,
      this.lastDate,
      this.isTitleVisible = true,
      this.hintText,
      this.dateFormat, this.initialDateShowPicker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FIRST DATE :$firstDate');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isTitleVisible)
          Text(titleText.toUpperCase(), style: FontTextStyle.poppinsW6S12Grey),
        if (titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
        DateTimeField(
          initialValue: initialValue,
          validator: (value) {
            return isValidate == false
                ? null
                : value != null
                    ? null
                    : ValidationMsg.isRequired;
          },
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          format: DateFormat(dateFormat ?? DateFormatUtils.ddMMYYYYString),
          decoration: InputDecoration(
              focusedBorder: DecorationUtils.outLinePurpleR8,
              enabledBorder: DecorationUtils.outLineGeryR8,
              disabledBorder: DecorationUtils.outLineGeryR8,
              errorBorder: DecorationUtils.outLineRedR8,
              focusedErrorBorder: DecorationUtils.outLineRedR8,
              filled: true,
              contentPadding: EdgeInsets.only(
                  top: Get.height * 0.018,
                  bottom: Get.height * 0.018,
                  left: 15,
                  right: 5),
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: 40, maxHeight: 40),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  ConstUtils.kCalenderIcon,
                  color: ColorUtils.grey,
                  size: 20,
                ),
              ),
              fillColor: ColorUtils.white,
              hintStyle: FontTextStyle.poppinsW5S12Grey,
              hintText: hintText ?? titleText),
          onShowPicker: (context, currentValue) async {
            print('FIRST DATE :$firstDate');

            final date = await showDatePicker(
                context: context,
                initialDatePickerMode: DatePickerMode.day,
                firstDate: firstDate ?? DateTime.now(),
                // firstDate: DateTime.now(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: lastDate ?? DateTime(2300));
            if (date != null) {
              onChangeDateTime!(date);
              return date;
            } else {
              return currentValue;
            }
          },
        ),
      ],
    );
  }
}
