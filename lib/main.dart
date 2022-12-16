import 'package:flutter/material.dart';

import 'component/camera_review_component.dart';

void main() {
  runApp(
    const CameraDetectFaceApp(),
  );
}

class CameraDetectFaceApp extends StatelessWidget {
  const CameraDetectFaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CameraReviewComponent(),
      ),
    );
  }
}
