import 'package:flutter/material.dart';
import 'package:onix_bot/core/invoices_widgets/common_widgets2/CustomTableView.dart';
import 'package:onix_bot/core/invoices_widgets/common_widgets2/custom_table_row.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


PWCustomTableView itemTable(BuildContext bcontext) {
  return PWCustomTableView(
    enableBoreder: false,
childrenTableRow: [
  // Header Row
  PWCustomTableRow(
    
    color: const PdfColorGrey(0.9), // Custom header color
    childrenList: [
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'total'.tr(bcontext),
              style: const pw.TextStyle(fontSize: 8)),
          
        ]),
      ),
      
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'price'.tr(bcontext),
              style: const pw.TextStyle(fontSize: 8)),
         
        ]),
      ),

     
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'quantity'.tr(bcontext),
              style: const pw.TextStyle(fontSize: 8)),
         
        ]),
      ),
      
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Column(children: [
          pw.Text(
              maxLines: 3,
              'product'.tr(bcontext),
              style: const pw.TextStyle(fontSize: 8)),
       
        ]),
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
            '300',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '4',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
     
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            'منتج 1',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
     
    ],
  ),

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
            '300',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            '4',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
     
      pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 5),
        child: pw.Text(
            maxLines: 3,
            'منتج 2',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.black)),
      ),
     
    ],
  ),


],
);
}
