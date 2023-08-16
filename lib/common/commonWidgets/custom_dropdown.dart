/// KEY : customDropDown
/// Desc. : Add Custom Custom DropDown
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/decoration_utils.dart';
import 'package:msp_educare_demo/utils/font_style_utils.dart';
import 'package:msp_educare_demo/utils/typedef_utils.dart';
import 'package:msp_educare_demo/utils/validation_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class CustomDropDown extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CustomDropDown(
      {this.value,
      required this.titleText,
      this.isValidate = true,
      required this.listData,
      required this.onChangeString});

  final dynamic value;
  final List<String>? listData;
  final OnChangeDynamic onChangeString;
  final String titleText;
  final bool? isValidate;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // String? selectedValue;

  @override
  void initState() {
    // print('WIDGET :=>${widget.value}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.titleText != "")
        Text(widget.titleText.toUpperCase(),
            style: FontTextStyle.poppinsW6S12Grey),
        if (widget.titleText != "")
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
        DropdownButtonFormField<String>(
          items: widget.listData!
              .map((e) => DropdownMenuItem(
                    child: Text('$e'),
                    value: e,
                  ))
              .toList(),
          value: widget.value,
          icon: Icon(
            ConstUtils.kDownArrowIcon,
            color: widget.listData?.isEmpty==true?ColorUtils.lightGrey:ColorUtils.grey,
          ),
          validator:
              widget.isValidate! ? ValidationMethod.validateIsRequired : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: FontTextStyle.poppinsW5S16Black,
          onChanged: (String? value) {
            widget.onChangeString(value);
            // setState(() {
            //   selectedValue = value;
            //   Future.delayed(Duration(milliseconds: 10), () {
            //     selectedValue = null;
            //   });
            // });
          },
          hint: Text(
            VariableUtils.select,
            style: FontTextStyle.poppinsW5S12Grey,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: Get.height * 0.018,
                bottom: Get.height * 0.018,
                left: 15,
                right: 5),
            focusedBorder: DecorationUtils.outLinePurpleR8,
            enabledBorder: DecorationUtils.outLineGeryR8,
            disabledBorder: DecorationUtils.outLineGeryR8,
            errorBorder: DecorationUtils.outLineRedR8,
            focusedErrorBorder: DecorationUtils.outLineRedR8,
            fillColor: ColorUtils.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
