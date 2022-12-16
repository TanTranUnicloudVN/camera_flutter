import 'dart:math';

import 'package:dynamic_camera_detect_face_flutter/common/check_render_size.dart';
import 'package:dynamic_camera_detect_face_flutter/widget/box_rect_paint_widget.dart';
import 'package:flutter/material.dart';

import 'box_circle_paint_widget.dart';

class OverlayCameraWidget extends StatelessWidget {
  const OverlayCameraWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RenderSizeChecker renderSizeChecker = RenderSizeChecker(context);
    Point nosePoint = renderSizeChecker.getPoint(
      const Point(175, 250),
    );
    Rect faceRect = renderSizeChecker.getRectBox(
      const Rect.fromLTWH(
        60,
        70,
        200,
        300,
      ),
    );

    Rect acceptRect = renderSizeChecker.getRectBox(
      const Rect.fromLTWH(
        30,
        50,
        400,
        300,
      ),
    );

    Rect noseRect = renderSizeChecker.getRectBox(
      const Rect.fromLTWH(
        100,
        150,
        40,
        60,
      ),
    );
    return Stack(
      children: [
        //================
        CustomPaint(
          painter: BoxRectPaint(
            top: faceRect.top,
            left: faceRect.left,
            width: faceRect.width,
            height: faceRect.height,
            color: Colors.pink,
          ),
        ),
        //=================
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.black54,
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: acceptRect.top, left: acceptRect.left),
                width: acceptRect.width,
                height: acceptRect.height,
                color: Colors.red,
              ),
            ],
          ),
        ),

        //=================
        CustomPaint(
          painter: BoxRectPaint(
            top: acceptRect.top,
            left: acceptRect.left,
            width: acceptRect.width,
            height: acceptRect.height,
            color: Colors.orangeAccent,
          ),
        ),
        CustomPaint(
          painter: BoxRectPaint(
            top: noseRect.top,
            left: noseRect.left,
            width: noseRect.width,
            height: noseRect.height,
            color: Colors.yellow,
          ),
        ),
        CustomPaint(
          painter: BoxCirclePaint(
            x: nosePoint.x.toDouble(),
            y: nosePoint.y.toDouble(),
            radius: 5,
            color: Colors.green,
          ),
        ),
        Positioned(
          bottom: renderSizeChecker.getSize(30),
          width: renderSizeChecker.getSize(480),
          child: Center(
            child: Text(
              "responseText",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: renderSizeChecker.getSize(24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
