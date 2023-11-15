part of 'camera_frame_back_bloc.dart';

@immutable
abstract class CameraFrameBackState {}

class CameraFrameBackInitial extends CameraFrameBackState {}

class CameraFrameTakePhotoLoadingState extends CameraFrameBackState {}

class CameraFrameTakePhotoSuccessState extends CameraFrameBackState {
  final image;

  CameraFrameTakePhotoSuccessState(this.image);
}

class CameraFrameTakePhotoErrorState extends CameraFrameBackState {
  String errorMSG;

  CameraFrameTakePhotoErrorState(this.errorMSG);
}
