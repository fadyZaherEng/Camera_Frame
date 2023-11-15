// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewWidget extends StatefulWidget {
  CameraController controller;
  String imagePath;

  CameraViewWidget({
    required this.controller,
    required this.imagePath,
    super.key,
  });

  @override
  State<CameraViewWidget> createState() => _CameraViewWidgetState();
}

class _CameraViewWidgetState extends State<CameraViewWidget> {
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
        width: 280,
        height: 160,
        child: ClipRRect(
          child: OverflowBox(
            maxHeight: screenratio > previewratio
                ? screenh
                : screenw / previeww * previewh,
            maxWidth: screenratio > previewratio
                ? (screenh / previewh) * previeww
                : screenw,
            child: AspectRatio(
              aspectRatio: 1 / widget.controller.value.aspectRatio + 0.05,
              child: Image.file(
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
                File(
                  widget.imagePath,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
