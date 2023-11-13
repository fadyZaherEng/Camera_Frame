part of 'camera_frame_bloc.dart';

@immutable
abstract class CameraFrameEvent {}

class CameraTakePhotoEvent extends CameraFrameEvent {
  CameraController cameraController;

  CameraTakePhotoEvent({required this.cameraController});
}
