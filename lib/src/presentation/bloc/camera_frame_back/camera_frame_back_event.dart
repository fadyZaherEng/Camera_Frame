part of 'camera_frame_back_bloc.dart';

@immutable
abstract class CameraFrameBackEvent {}

class CameraTakePhotoEvent extends CameraFrameBackEvent {
  CameraController cameraController;

  CameraTakePhotoEvent({required this.cameraController});
}
