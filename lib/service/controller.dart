import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Controller extends GetxController{
  var error = ''.obs;
  var isTorch=false.obs;
  Rx<CameraFacing> isCamera = CameraFacing.front.obs;
  var listcount = 0.obs;
}