
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

//  pw.Widget invoiceSummary() {
//     return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
//       pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           _summaryRowa(
//             'عدد القطع',
//             '6',
//           ),
//           //  pw.Container(
//           //       width: 100,
//           //       child: pw.Divider(thickness: 0.5, color: const PdfColorGrey(0.3))),
//           _summaryRowa('الإجمالي', '1200'),
//           _summaryRowa('الضريبة', '200'),
//           _summaryRowa('الصافي', '1400'),
//           _summaryRowa('المبلغ المدفوع', '1400'),
//           _summaryRowa('الباقي', '0.00'),
//         ],
//       )
//     ]);
//   }
//   pw.Widget _summaryRowa(String label, String value) {
//     return pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Row(
//             mainAxisSize: pw.MainAxisSize.min,
//             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             children: [
//               pw.SizedBox(
//                   width: 70,
//                   child: pw.Text(label, style: pw.TextStyle(fontSize: 8))),
//               // pw.SizedBox(width: 20),
//               pw.Text(value, style: pw.TextStyle(fontSize: 8)),
//             ],
//           ),
//           pw.Container(
//               width: 130,
//               child: pw.Divider(thickness: 0.2, color: const PdfColorGrey(0.3)))
//         ]);
//   }
