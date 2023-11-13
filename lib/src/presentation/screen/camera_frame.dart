// ignore_for_file: library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:camera_frame/src/presentation/bloc/camera_frame/camera_frame_bloc.dart';
import 'package:camera_frame/src/presentation/screen/widget/camera_frame_widget.dart';
import 'package:camera_frame/src/presentation/screen/widget/camera_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraFrame extends StatefulWidget {
  dynamic cameras;
  CameraFrame({Key? key, required this.cameras}) : super(key: key);
  @override
  _CameraFrameState createState() => _CameraFrameState();
}

class _CameraFrameState extends State<CameraFrame> {
  CameraController? _controller;
  String _imagePath = "";

  CameraFrameBloc get _bloc => BlocProvider.of<CameraFrameBloc>(context);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras.first, ResolutionPreset.high,
        enableAudio: false);
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller!.value.isInitialized) {
      return Scaffold(
        body: Container(),
      );
    }
    return BlocConsumer<CameraFrameBloc, CameraFrameState>(
      listener: (context, state) {
        if (state is CameraFrameTakePhotoSuccessState) {
          _imagePath = state.image;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CameraFrameWidget(controller: _controller!),
                const SizedBox(
                  height: 50,
                ),
                if (_imagePath != "")
                  CameraViewWidget(
                    controller: _controller!,
                    imagePath: _imagePath,
                  ),
                TextButton(
                  onPressed: () {
                    _bloc.add(
                      CameraTakePhotoEvent(
                        cameraController: _controller!,
                      ),
                    );
                  },
                  child: const Text("Take Photo"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
