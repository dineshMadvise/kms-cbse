import 'package:flutter/material.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/player_progess_color_model.dart';
import 'package:msp_educare_demo/utils/color_utils.dart';

import 'video_play_progress_bar.dart';

class CustomVideoProgressIndicator extends StatelessWidget {
  final Duration videoDuration;
  final Duration currentPosition;
  final bool isProgressCircleVisible;
  final Color? progressColor;

  const CustomVideoProgressIndicator(
      {Key? key,
      required this.videoDuration,
      required this.currentPosition,
      required this.isProgressCircleVisible,
      this.progressColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorUtils.transparent,
        margin: const EdgeInsets.only(bottom: 5),
        child: CustomPaint(
          painter: ProgressBarPainter(
              videoDuration,
              currentPosition,
              PlayerProgressColorsModel(
                playedColor: progressColor ?? ColorUtils.blue,
              ),
              isProgressCircleVisible),
        ),
      ),
    );
  }
}
