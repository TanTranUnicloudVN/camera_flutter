import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widget/liveness_camera_review_widget.dart';
import '../widget/overlay_widget.dart';

class CameraReviewComponent extends StatefulWidget {
  const CameraReviewComponent({super.key});

  @override
  State<CameraReviewComponent> createState() => _CameraReviewComponentState();
}

class _CameraReviewComponentState extends State<CameraReviewComponent> {
  List<CameraDescription>? cameras;
  String? errorRenderMessage;

  @override
  void initState() {
    getCameras();
    super.initState();
  }

  Future getCameras() async {
    try {
      final currentCameras = await availableCameras();
      setState(() {
        cameras = currentCameras;
      });
    } catch (e) {
      setState(() {
        errorRenderMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return cameras != null
        ? LivenessCameraReviewWidget(
            cameraDescription: cameras!.first,
            setCamraSizeBloc: ({height = 10, width = 10}) {
              debugPrint("$height $width");
            },
            overlayWidget: const OverlayCameraWidget(),
          )
        : const SizedBox.shrink();
  }
}
