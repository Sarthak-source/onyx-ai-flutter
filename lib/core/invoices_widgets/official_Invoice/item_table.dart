
import 'package:onix_bot/core/invoices_widgets/common_widgets2/CustomTableView.dart';
import 'package:onix_bot/core/invoices_widgets/common_widgets2/custom_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


PWCustomTableView itemTable(pw.TextDirection dir) {
  return PWCustomTableView(
childrenTableRow: [
  // Header Row
  PWCustomTableRow(
    isRtl:dir ==pw.TextDirection.rtl ,
    color: PdfColor.fromHex("#1E90FF"), // Custom header color
    childrenList: [
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'الاجمالي',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'Total',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'الضريبة (%)',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'TAX',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'السعر',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'Price',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),

      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'الكمية المجانية',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'Free QTY',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'الكمية',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'QTY',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'الوحدة',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'Unit',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'اسم الصنف',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
          pw.Text(
              maxLines: 3,
              'Item Name',
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.white))
        ]),
      ),

      //-last
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Text(
            maxLines: 3,
            'م',
            textAlign: pw.TextAlign.center,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
      ),
    ],
  ),

  // Body Row
  PWCustomTableRow(
    childrenList: [
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '1200',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '10',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '300',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '0',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '4',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            'حبة',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '90-90خدمات وصيانة',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '1',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
    ],
  ),
  PWCustomTableRow(
    color: const PdfColorGrey(0.9),
    childrenList: [
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '1200',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '10',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '300',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '0',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '4',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            'حبة',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '90-90خدمات وصيانة',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '1',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
    ],
  ),

  // Footer Row
],
);
}
