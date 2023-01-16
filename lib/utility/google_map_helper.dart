// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart' hide Image;
// import 'package:flutter/services.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:image/image.dart' as IMG;

// Future<BitmapDescriptor> getMarkerIcon({
//   String? text,
//   required Size size,
//   bool selected = false,
//   bool isCurrentLocation = false,
//   double? fontSize,
//   double? fontHeight,
//   // String markerIcon = AppAssets.markerIcon,
// }) async {
//   final pictureRecorder = ui.PictureRecorder();
//   final canvas = Canvas(pictureRecorder);
//   // final image = await _loadImage(markerIcon);
//   _RPSCustomPainter(
//     text: text,
//     selected: selected,
//     fontSize: fontSize,
//     fontHeight: fontHeight,
//     image: image,
//     isCurrentLocation: isCurrentLocation,
//   ).paint(
//     canvas,
//     Size(
//       size.width,
//       size.width,
//     ),
//   );
//   // Convert canvas to image
//   final markerAsImage = await pictureRecorder.endRecording().toImage(
//         size.width.toInt(),
//         size.width.toInt(),
//       );

//   // Convert image to bytes
//   final byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
//   final uint8List = byteData!.buffer.asUint8List();

//   return BitmapDescriptor.fromBytes(uint8List);
// }

// class _RPSCustomPainter extends CustomPainter {
//   _RPSCustomPainter({
//     this.text,
//     this.selected = false,
//     this.fontSize,
//     this.fontHeight,
//     this.isCurrentLocation = false,
//     required this.image,
//   });

//   final String? text;
//   final bool selected;
//   final double? fontSize;
//   final double? fontHeight;
//   final bool isCurrentLocation;
//   final ui.Image image;

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint1 = Paint();
//     //a circle

//     // canvas.drawRect(
//     //     Rect.fromLTWH(0, 0, 300, 300),
//     //     Paint()
//     //       ..color = Colors.blue
//     //       ..style = PaintingStyle.fill);
//     canvas.drawImage(image, Offset(0, 13), paint1);

//     var paint2 = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     if (text != null) {
//       canvas.drawCircle(Offset(65, 21), 23, paint2);
//       final span = TextSpan(
//         style: TextStyle(
//           color: AppColors.darkgreen,
//           fontSize: 30,
//         ),
//         text: text,
//       );

//       final textOffSet = text!.length >= 2 ? Offset(47, 8) : Offset(55, 8);
//       TextPainter(
//         text: span,
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.center,
//       )
//         ..layout()
//         ..paint(canvas, textOffSet);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// Future<ui.Image> _loadImage(String imagePath) async {
//   ByteData bd = await rootBundle.load(imagePath);

//   final Uint8List bytes = Uint8List.view(bd.buffer);
//   final data = bytes.map((e) => e).toList();
//   final IMG.Image? image = IMG.decodeImage(data);
//   final IMG.Image resized = IMG.copyResize(image!, width: 70, height: 70);
//   final List<int> resizedBytes = IMG.encodePng(resized);
//   final Completer<ui.Image> completer = new Completer();

//   ui.decodeImageFromList(Uint8List.fromList(resizedBytes), (ui.Image img) => completer.complete(img));
//   return completer.future;
// }

// Future<Uint8List> getBytesFromCanvas(int width, int height, urlAsset) async {
//   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(pictureRecorder);

//   var imaged = await _loadImage(AppAssets.markerIcon);
//   canvas.drawImageRect(
//     imaged,
//     Rect.fromLTRB(0.0, 0.0, imaged.width.toDouble(), imaged.height.toDouble()),
//     Rect.fromLTRB(0.0, 0.0, width.toDouble(), height.toDouble()),
//     new Paint(),
//   );
//   var paint2 = Paint()
//     ..color = Colors.white
//     ..style = PaintingStyle.fill;
//   canvas.drawCircle(Offset(50, 18), 18, paint2);

//   final img = await pictureRecorder.endRecording().toImage(width, height);
//   final data = await img.toByteData(format: ui.ImageByteFormat.png);
//   return data!.buffer.asUint8List();
// }
