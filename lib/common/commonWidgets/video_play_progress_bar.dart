import 'package:flutter/material.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/player_progess_color_model.dart';

class ProgressBarPainter extends CustomPainter {
  ProgressBarPainter(
      this.duration, this.position, this.colors, this.isProgressCircleVisible);

  PlayerProgressColorsModel colors;

  Duration duration;
  Duration position;
  bool isProgressCircleVisible;

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const height = 6.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(size.width, size.height / 2 + height),
        ),
        const Radius.circular(0.0),
      ),
      colors.backgroundPaint,
    );
    // if (!value.initialized) {
    //   return;
    // }
    double playedPartPercent =
        position.inMilliseconds / duration.inMilliseconds;
    if (playedPartPercent.isNaN) {
      playedPartPercent = 0;
    }
    final double playedPart =
        playedPartPercent > 1 ? size.width : playedPartPercent * size.width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(playedPart, size.height / 2 + height),
        ),
        const Radius.circular(0.0),
      ),
      colors.playedPaint,
    );
    if (isProgressCircleVisible) {
      canvas.drawCircle(
        Offset(playedPart, size.height / 2 + height / 2),
        6,
        colors.handlePaint,
      );
    }
  }
}
