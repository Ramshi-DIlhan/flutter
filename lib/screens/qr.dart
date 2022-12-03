import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCamera extends StatelessWidget {
  String uid;
  Function update;
  QrCamera({Key? key,required this.uid, required this.update}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcode,args){
        if(barcode.rawValue!=null){
          DatabaseService(uid: uid).playerJob(barcode.rawValue, update,context);
        }
      },
      allowDuplicates: false,
    );
  }
}
