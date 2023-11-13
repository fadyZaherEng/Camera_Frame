// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? controller;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras!.first, ResolutionPreset.high);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tmp = MediaQuery.of(context).size;

    final screenh = tmp.height > tmp.width ? tmp.height : tmp.width;
    final screenw = tmp.width > tmp.height ? tmp.height : tmp.width;

    tmp = controller!.value.previewSize!;

    final previewh = tmp.height > tmp.width ? tmp.height : tmp.width;
    final previeww = tmp.width > tmp.height ? tmp.height : tmp.width;
    final screenratio = screenh / screenw;
    final previewratio = previewh / previeww;
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 160,
              child: ClipRRect(
                child: OverflowBox(
                  maxHeight: screenratio > previewratio
                      ? screenh
                      : screenw / previeww * previewh,
                  maxWidth: screenratio > previewratio
                      ? screenh / previewh * previeww
                      : screenw,
                  child: AspectRatio(
                    aspectRatio: 1 / controller!.value.aspectRatio,
                    child: CameraPreview(
                      controller!,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (imagePath != "")
              SizedBox(
                width: 350,
                height: 160,
                child: ClipRRect(
                  child: OverflowBox(
                    maxHeight: screenratio > previewratio
                        ? screenh
                        : screenw / previeww * previewh,
                    maxWidth: screenratio > previewratio
                        ? screenh / previewh * previeww
                        : screenw,
                    child: AspectRatio(
                      aspectRatio: 1 / controller!.value.aspectRatio,
                      child: Image.file(
                        isAntiAlias: true,
                        width: 380,
                        height: 180,
                        File(imagePath),
                      ),
                    ),
                  ),
                ),
              ),
            TextButton(
              onPressed: () async {
                try {
                  final image = await controller!.takePicture();
                  setState(() {
                    imagePath = image.path;
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Take Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
