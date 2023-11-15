import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'camera_frame_back_event.dart';
part 'camera_frame_back_state.dart';

class CameraFrameBackBloc
    extends Bloc<CameraFrameBackEvent, CameraFrameBackState> {
  CameraFrameBackBloc() : super(CameraFrameBackInitial()) {
    on<CameraTakePhotoEvent>(_onCameraTakePhotoEvent);
  }

  FutureOr<void> _onCameraTakePhotoEvent(
      CameraTakePhotoEvent event, Emitter<CameraFrameBackState> emit) async {
    emit(CameraFrameTakePhotoLoadingState());
    try {
      event.cameraController.setFlashMode(FlashMode.off);
      final image = await event.cameraController.takePicture();
      emit(CameraFrameTakePhotoSuccessState(image.path));
    } catch (e) {
      emit(CameraFrameTakePhotoErrorState(e.toString()));
    }
  }
}
