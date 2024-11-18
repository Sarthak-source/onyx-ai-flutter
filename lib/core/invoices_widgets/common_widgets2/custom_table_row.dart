import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// pw.TableRow PWCustomTableRow({
//   required List<pw.Widget> childrenList,
//   PdfColor? color,
//   bool withBorder=true,

// }) {
//   return pw.TableRow(
    
//     decoration:withBorder? pw.BoxDecoration(
//       color: color ?? PdfColors.white,
//       border: pw.Border.all(color: color ?? PdfColors.white),
//     ):null,
//     children: childrenList,
//   );
// }

pw.TableRow PWCustomTableRow({
  required List<pw.Widget> childrenList,
  PdfColor? color,
  bool withBorder = true,
  bool isRtl = false, // New parameter to check for RTL
}) {
  return pw.TableRow(
    decoration: withBorder
        ? pw.BoxDecoration(
            color: color ?? PdfColors.white,
            border: pw.Border.all(color: color ?? PdfColors.white),
          )
        : null,
    children: isRtl
        ? childrenList.map((child) {
            return pw.Column(
              children: [child], // Stack each child vertically
            );
          }).toList()
        : childrenList.reversed.map((child) {
            return pw.Column(
              children: [child], // Stack each child vertically
            );
          }).toList(),
  );
}
