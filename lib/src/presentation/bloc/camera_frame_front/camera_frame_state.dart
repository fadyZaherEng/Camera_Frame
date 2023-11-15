// ignore_for_file: prefer_typing_uninitialized_variables

part of 'camera_frame_bloc.dart';

@immutable
abstract class CameraFrameState {}

class CameraFrameInitial extends CameraFrameState {}

class CameraFrameTakePhotoLoadingState extends CameraFrameState {}

class CameraFrameTakePhotoSuccessState extends CameraFrameState {
  final image;

  CameraFrameTakePhotoSuccessState(this.image);
}

class CameraFrameTakePhotoErrorState extends CameraFrameState {
  String errorMSG;

  CameraFrameTakePhotoErrorState(this.errorMSG);
}
