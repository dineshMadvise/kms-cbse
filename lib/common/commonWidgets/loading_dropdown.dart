
import 'package:flutter/material.dart';
import 'package:msp_educare_demo/common/commonWidgets/custom_dropdown.dart';

class LoadingDropDown extends StatelessWidget {
  final String title;

  const LoadingDropDown({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropDown(
      titleText: title,
      listData: [],
      value: null,
      onChangeString: (value) {},
    );
  }
}
