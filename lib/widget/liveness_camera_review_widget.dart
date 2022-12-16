import 'package:camera/camera.dart';
import 'package:dynamic_camera_detect_face_flutter/common/check_render_size.dart';
import 'package:flutter/material.dart';

class LivenessCameraReviewWidget extends StatefulWidget {
  const LivenessCameraReviewWidget({
    Key? key,
    required this.cameraDescription,
    required this.setCamraSizeBloc,
    this.overlayWidget,
  }) : super(key: key);

  final CameraDescription? cameraDescription;

  final Function({
    required double height,
    required double width,
  }) setCamraSizeBloc;

  final Widget? overlayWidget;

  @override
  State<LivenessCameraReviewWidget> createState() =>
      _LivenessCameraReviewWidgetState();
}

class _LivenessCameraReviewWidgetState extends State<LivenessCameraReviewWidget>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool? isDisposeCamera;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.cameraDescription != null) {
      onNewCameraSelected();
    }
  }

  /// initialize camera
  void onNewCameraSelected() async {
    if (controller != null) {
      isDisposeCamera = true;
      setState(() {});
      await controller?.dispose().then((value) => controller = null);
    }
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    } catch (e) {
      // DebugLogger().log(e);
    } finally {
      controller = CameraController(
          widget.cameraDescription!, ResolutionPreset.high,
          enableAudio: false);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        isDisposeCamera = false;
        setState(() {});
        // context.read<LivenessBloc>().add(const LivenessEventStart(
        //       height: 480,
        //       width: 580,
        //     ));
        widget.setCamraSizeBloc(height: 480, width: 580).call();
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              break;
            default:
              break;
          }
        }
      });
    }
  }

  /// Dispose camera
  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Control camera when widget in background mode
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected();
    }
  }
  // #enddocregion AppLifecycle

  @override
  Widget build(BuildContext context) {
    const Size cameraPreviewSize = Size(480, 580);
    RenderSizeChecker responsive = RenderSizeChecker(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (isDisposeCamera == false)
            if (controller != null &&
                controller?.value.isInitialized == true) ...[
              SizedBox.fromSize(
                size: responsive.cameraSize,
                child: controller != null
                    ? CameraPreview(controller!)
                    : Container(
                        color: Colors.black,
                        width: cameraPreviewSize.width,
                        height: cameraPreviewSize.height,
                      ),
              ),
              SizedBox.fromSize(
                size: responsive.cameraSize,
                // child: const LivenessOverlayBoxWidget(),
                child: widget.overlayWidget,
              ),
            ] else ...[
              SizedBox.fromSize(
                size: cameraPreviewSize,
                child: Material(
                  color: Colors.blue.shade100.withOpacity(0.5),
                ),
              ),
            ]
          else ...[
            SizedBox.fromSize(
              size: responsive.cameraSize,
              child: Material(
                color: Colors.blue.shade100.withOpacity(0.5),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
