import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFrameWidget extends StatefulWidget {
  CameraController controller;

  CameraFrameWidget({
    required this.controller,
    super.key,
  });

  @override
  State<CameraFrameWidget> createState() => _CameraFrameWidgetState();
}

class _CameraFrameWidgetState extends State<CameraFrameWidget> {
  @override
  Widget build(BuildContext context) {
    var tmp = MediaQuery.of(context).size;
    final screenh = tmp.height > tmp.width ? tmp.height : tmp.width;
    final screenw = tmp.width > tmp.height ? tmp.height : tmp.width;
    if (widget.controller.value.previewSize != null) {
      tmp = widget.controller.value.previewSize!;
    }

    final previewh = tmp.height > tmp.width ? tmp.height : tmp.width;
    final previeww = tmp.width > tmp.height ? tmp.height : tmp.width;

    final screenratio = screenh / screenw;
    final previewratio = previewh / previeww;
    return Center(
      child: SizedBox(
        width: 300,
        height: 160,
        child: ClipRRect(
          child: OverflowBox(
            maxHeight: screenratio > previewratio
                ? screenh
                : screenw / previeww * previewh,
            maxWidth: screenratio > previewratio
                ? screenh / previewh * previeww
                : screenw,
            child: AspectRatio(
              aspectRatio: 1 / widget.controller.value.aspectRatio + 0.05,
              child: CameraPreview(widget.controller),
            ),
          ),
        ),
      ),
    );
  }
}
