import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gitpod_flutter_quickstart/screens/login_page.dart';
import 'package:gitpod_flutter_quickstart/screens/sign_up_page.dart';
import 'package:gitpod_flutter_quickstart/service/firebase.dart';

late List<CameraDescription> cameras;
late CameraController camcontroller;

void main() async {
  await firebaseInit();
  await initCamera();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Treasure Hunt',
      home: LoginPage(),
    );
  }
}

Future initCamera() async {
  cameras = await availableCameras();
  camcontroller = CameraController(cameras.last, ResolutionPreset.medium);
  await camcontroller.initialize();
}
