// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'camera_frame_event.dart';
part 'camera_frame_state.dart';

class CameraFrameBloc extends Bloc<CameraFrameEvent, CameraFrameState> {
  CameraFrameBloc() : super(CameraFrameInitial()) {
    on<CameraTakePhotoEvent>(_onCameraTakePhotoEvent);
  }

  FutureOr<void> _onCameraTakePhotoEvent(
      CameraTakePhotoEvent event, Emitter<CameraFrameState> emit) async {
    emit(CameraFrameTakePhotoLoadingState());
    try {
      event.cameraController.setFlashMode(FlashMode.off);
      final image = await event.cameraController.takePicture();
      emit(CameraFrameTakePhotoSuccessState(image.path));
    } catch (e) {
      print(e);
      emit(CameraFrameTakePhotoErrorState(e.toString()));
    }
  }
}
