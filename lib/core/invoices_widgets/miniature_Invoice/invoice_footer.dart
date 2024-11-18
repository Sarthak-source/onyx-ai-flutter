import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceFooter({required Uint8List zatcaEncodedData}) {
  return pw.Column(children: [
    pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text('العنوان: ', style: pw.TextStyle(fontSize: 8)),
        pw.Text('الملقا طريق الملك فهد', style: pw.TextStyle(fontSize: 8)),
      ],
    ),
    // pw.SizedBox(height: 10),
     pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text('الهاتف: ', style: pw.TextStyle(fontSize: 8)),
        pw.Text(' 5345-5435-977', style: pw.TextStyle(fontSize: 8)),
      ],
    ),
    pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(8),
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(5),
        border: pw.Border.all(color: const PdfColorGrey(0.5), width: 1),
      ),
      child: pw.Text('شروط الاسترجاع 7 أيام من تاريخ الفاتورة',
          style: const pw.TextStyle(fontSize: 8)),
    ),
    pw.SizedBox(height: 20),
    pw.BarcodeWidget(
      barcode: pw.Barcode.qrCode(),
      data: base64Encode(zatcaEncodedData),
      width: 50,
      height: 50,
    ),
  ]);
}
