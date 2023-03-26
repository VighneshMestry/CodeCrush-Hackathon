// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

// class QrScanner extends StatefulWidget {
//   const QrScanner({super.key});

//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }

// class _QrScannerState extends State<QrScanner> {
  // Future _qrScanner () async {
  //   var cameraStatus = await Permission.camera.status;
  //   if(cameraStatus.isGranted){
  //     String? qrData = await scanner.scan();
  //     print(qrData);
  //   } else {
  //     var isGrant = await Permission.camera.request();

  //     if(isGrant.isGranted) {
  //       String? qrData = await scanner.scan();
  //       print(qrData);
  //     }
  //   }
  // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: _qrScanner(),
//       ),
//     );
//   }
// }