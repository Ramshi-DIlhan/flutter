import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCamera extends StatelessWidget {
  var ctx;
  String uid;
  Function update;
  MobileScannerController cont;
  QrCamera({Key? key,required this.uid, required this.update,required this.ctx,required this.cont}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: cont,
      onDetect: (barcode,args){
        if(barcode.rawValue!=null){
          DatabaseService(uid: uid).playerJob(barcode.rawValue, update,ctx);
        }
      },
      allowDuplicates: false,
    );
  }
}
