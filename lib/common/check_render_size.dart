import 'dart:math';

import 'package:flutter/material.dart';

class RenderSizeChecker {
  Size cameraSize = const Size(0, 0);

  static const double _designWidth = 1920;
  static const double _designHeight = 1200;
  static const double _mediumWidth = 1536;
  static const double _mediumHeight = 1000;
  static const double _minWidth = 1024;
  static const double _minHeight = 720;

  RenderSizeChecker(
    BuildContext context, {
    double? renderHeight,
    double? renderWidth,
  }) {
    double widthScreen = renderWidth ?? MediaQuery.of(context).size.width;
    double heightScreen = renderHeight ?? MediaQuery.of(context).size.height;
    if (widthScreen > _designWidth) {
      if (cameraSize.width != 672) {
        cameraSize = const Size(672, 812);
      }
    } else if (widthScreen > _mediumWidth) {
      if (cameraSize.width != 480) {
        cameraSize = const Size(480, 580);
      }
    } else if (widthScreen > _minWidth) {
      if (cameraSize.width != 384) {
        cameraSize = const Size(384, 464);
      }
    } else {
      if (cameraSize.width != 264) {
        cameraSize = const Size(264, 319);
      }
    }

    if (heightScreen > _designHeight) {
      if (cameraSize.height != 0) {
        cameraSize = const Size(672, 812);
      }
    } else if (heightScreen > _mediumHeight) {
      if (cameraSize.height != 0) {
        cameraSize = const Size(480, 580);
      }
    } else if (heightScreen > _minHeight) {
      if (cameraSize.height != 0) {
        cameraSize = const Size(384, 464);
      }
    } else {
      if (cameraSize.height != 0) {
        cameraSize = const Size(264, 319);
      }
    }
  }

  Rect getRectOverlay() {
    if (cameraSize.width == 672) {
      return const Rect.fromLTWH(112, 154, 448, 448);
    } else if (cameraSize.width == 480) {
      return const Rect.fromLTWH(80, 110, 320, 320);
    } else if (cameraSize.width == 384) {
      return const Rect.fromLTWH(64, 88, 256, 256);
    } else {
      return const Rect.fromLTWH(44, 60.5, 176, 176);
    }
  }

  Rect getRectBox(Rect rect) {
    if (cameraSize.width == 672) {
      return Rect.fromLTWH(rect.left * 672 / 480, rect.top * 812 / 580,
          rect.width * 672 / 480, rect.height * 812 / 580);
    } else if (cameraSize.width == 480) {
      return rect;
    } else if (cameraSize.width == 384) {
      return Rect.fromLTWH(rect.left * 384 / 480, rect.top * 464 / 580,
          rect.width * 384 / 480, rect.height * 464 / 580);
    } else {
      return Rect.fromLTWH(rect.left * 264 / 480, rect.top * 319 / 580,
          rect.width * 264 / 480, rect.height * 319 / 580);
    }
  }

  Point getPoint(Point point) {
    if (cameraSize.width == 672) {
      return Point(point.x * 672 / 480, point.y * 812 / 580);
    } else if (cameraSize.width == 480) {
      return point;
    } else if (cameraSize.width == 384) {
      return Point(point.x * 384 / 480, point.y * 464 / 580);
    } else {
      return Point(point.x * 264 / 480, point.y * 319 / 580);
    }
  }

  double getSize(double size) {
    if (cameraSize.width == 672) {
      return size * 672 / 480;
    } else if (cameraSize.width == 480) {
      return size;
    } else if (cameraSize.width == 384) {
      return size * 384 / 480;
    } else {
      return size * 264 / 480;
    }
  }
}
