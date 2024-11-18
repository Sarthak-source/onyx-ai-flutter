import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onix_bot/core/invoices_widgets/common_widgets2/img_container_widget.dart';
import 'package:onix_bot/core/invoices_widgets/common_widgets2/pdf_view.dart';
import 'package:onix_bot/core/invoices_widgets/encription/encode_TLV_Data.dart';
import 'package:onix_bot/core/invoices_widgets/miniature_Invoice/invoice_summary.dart';
import 'package:onix_bot/core/invoices_widgets/miniature_Invoice/item_table.dart';
import 'package:onix_bot/core/invoices_widgets/official_Invoice/invoice_footer.dart';
import 'package:onix_bot/core/invoices_widgets/official_Invoice/invoice_info_table.dart';
import 'package:onix_bot/core/invoices_widgets/style/font.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';
import 'package:onix_bot/core/responsive_ext.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


Future<void> printMiniatureInvoice(BuildContext bcontext) async {
  // ZATCA-specific invoice data
  const sellerName = 'qaser';
  const vatRegistrationNumber = '1234567890';
  final timestamp = DateTime.now().toIso8601String();
  const totalAmount = '1000.00';
  const vatAmount = '150.00';

  // TLV Encoding for ZATCA compliance
  Uint8List zatcaEncodedData = encodeTLVData([
    ['1', sellerName],
    ['2', vatRegistrationNumber],
    ['3', timestamp],
    ['4', totalAmount],
    ['5', vatAmount],
  ]);

  pw.TextDirection dir =
      bcontext.isRTL ? pw.TextDirection.rtl : pw.TextDirection.ltr;
  final pdf = pw.Document();
  final imageContainer = await imgContainer(imgPath: 'assets/images/Logo.png');
  final defaulttextstyle = await PWAppTextStyles.getDefaultTextStyle();
  pdf.addPage(
    pw.Page(
      textDirection: dir,
      theme: pw.ThemeData.withFont(base: defaulttextstyle.font),
      build: (context) {
        return pw.Container(
            decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.only(
                    topLeft: pw.Radius.circular(10),
                    topRight: pw.Radius.circular(10))),
            child: pw.Column(
              children: [
                // Header
                pw.Container(
                  // color: const PdfColor.fromInt(0xFFF8F8F8),
                  child: pw.Column(
                    // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      imageContainer,

                      pw.Text('all_direct_selling_invoice'.tr(bcontext),
                          style: defaulttextstyle.copyWith(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              '${'tax_number'.tr(bcontext)} :',
                              style: defaulttextstyle.copyWith(fontSize: 9),
                            ),
                            pw.Text(
                              '849849849',
                              style: defaulttextstyle.copyWith(fontSize: 9),
                            ),
                          ]),
                      // pw.SizedBox(height: 15),
                      pw.Text("${'merchant_name'.tr(bcontext)} قصر الاواني",
                          style: defaulttextstyle.copyWith(
                              color: PdfColor.fromHex("#0C69C0"))),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(
                    borderStyle: pw.BorderStyle.dotted,
                    thickness: 0.2,
                    color: const PdfColorGrey(0.3)),
                // Invoice Info
                invoiceInfoTable(bcontext, dir),
                pw.Container(
                  margin: const pw.EdgeInsets.only(left: 30, right: 30),
                  child: pw.Row(children: [
                    pw.Text('${'client_name'.tr(bcontext)} : ',
                        style: defaulttextstyle.copyWith(
                            color: PdfColor.fromHex("#0C69C0"))),
                    pw.Text('اسلام سليمان-شركة المجد للصناعة',
                        style: defaulttextstyle),
                  ]),
                ),
                pw.Divider(
                    borderStyle: pw.BorderStyle.dotted,
                    thickness: 0.2,
                    color: const PdfColorGrey(0.3)),
                pw.SizedBox(height: 10),
                // Items Table
                itemTable(bcontext),
                // _buildItemsTable(),
                pw.SizedBox(height: 10),
                // Summary
                invoiceSummary(bcontext, dir),
                // Footer
                invoiceFooter(),
              ],
            ));
      },
    ),
  );
  // Preview the PDF
  if (bcontext.mounted) {
    showPreviewDialog(bcontext, pdf, bcontext.size!.width * 0.8);
  }
}
