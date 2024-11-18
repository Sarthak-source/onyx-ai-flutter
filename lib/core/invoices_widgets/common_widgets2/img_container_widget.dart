 
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
 
  Future<pw.Widget> imgContainer({required String imgPath,double width=50,double height=100 }) async {
    final imageBytes = await rootBundle.load(imgPath);

    return pw.Container(
      width: width,
      margin: const pw.EdgeInsets.only(left: 8, right: 8),
      height: height,
      child: pw.Image(
        pw.MemoryImage(imageBytes.buffer.asUint8List()),
        fit: pw.BoxFit.contain,
      ),
    );
  }