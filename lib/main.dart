// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:camera_frame/src/presentation/bloc/camera_frame_bloc/camera_frame_bloc.dart';
import 'package:camera_frame/src/presentation/screen/camera_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraFrameBloc(),
      child: MaterialApp(
        title: 'Flutter Camera Frame',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CameraFrame(cameras: cameras),
      ),
    );
  }
}
