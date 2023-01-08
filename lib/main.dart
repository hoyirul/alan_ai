import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<CameraDescription> cameras;
  late CameraController _cameraController;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async{
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0], 
      ResolutionPreset.high, 
      enableAudio: false);
    
    await _cameraController.initialize().then((value) {
      if(!mounted){
        return;
      }

      setState(() {});
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_cameraController.value.isInitialized){
      return Scaffold(
        // appBar: AppBar(title: const Text('Testing'),),
        body: Stack(
          children: [
            CameraPreview(_cameraController),
          ],
        )
      );
    }else{
      return const SizedBox();
    }
  }
}