import 'package:flutter/material.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';

class AddOrForwordCircleBox extends StatelessWidget {
  final icon;

  const AddOrForwordCircleBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: ColorUtils.lightGrey,
      child: Icon(
        icon,
        color: ColorUtils.blue,
        size: 20,
      ),
    );
  }
}
