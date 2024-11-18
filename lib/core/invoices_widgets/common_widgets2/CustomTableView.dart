import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PWCustomTableView extends pw.StatelessWidget {
  PWCustomTableView({
    required this.childrenTableRow,
    this.columnWidths,
    this.tableColor,
    this.enableBoreder=true
  });
  final bool enableBoreder;
  final List<pw.TableRow> childrenTableRow;
  final Map<int, pw.TableColumnWidth>? columnWidths;
  final PdfColor? tableColor;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: tableColor ?? PdfColors.white,
        borderRadius: const pw.BorderRadius.only(
          topRight: pw.Radius.circular(4),
          topLeft: pw.Radius.circular(4),
        ),
      ),
      child: pw.Table(
        columnWidths: columnWidths,
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        border:enableBoreder? pw.TableBorder.all(width: 1, color: PdfColors.grey):null,
        children: childrenTableRow,
      ),
    );
  }
}



// Usage example
