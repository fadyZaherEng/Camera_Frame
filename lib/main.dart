// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:camera/camera.dart';
import 'package:camera_frame/src/presentation/bloc/camera_frame_back/camera_frame_back_bloc.dart';
import 'package:camera_frame/src/presentation/bloc/camera_frame_front/camera_frame_bloc.dart';
import 'package:camera_frame/src/presentation/screen/card_back/camera_frame_back_screen.dart';
import 'package:camera_frame/src/presentation/screen/card_front/camera_frame_front_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CameraFrameFrontBloc(),
        ),
        BlocProvider(
          create: (context) => CameraFrameBackBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Camera Frame',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraFrameFrontScreen(
                      cameras: cameras,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.photo_camera_front,
                color: Colors.deepPurple,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraFrameBackScreen(
                      cameras: cameras,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.photo_camera_back,
                color: Colors.deepPurple,
                size: 50,
              ),
            )
          ],
        ),
      )),
    );
  }
}
