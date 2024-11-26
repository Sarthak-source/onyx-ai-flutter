
import 'package:flutter/material.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



  pw.Widget invoiceInfoTable(BuildContext bcontext,  pw.TextDirection dir) {
    return pw.Table(

      border: const pw.TableBorder(
        top: pw.BorderSide.none,
        bottom: pw.BorderSide.none,
        left: pw.BorderSide.none,
        right: pw.BorderSide.none,
        horizontalInside: pw.BorderSide.none,
        verticalInside: pw.BorderSide.none,
      ),
      children: [
        pw.TableRow(
          children: [
            _cell2(content: '10:24:21', showDivider: false),
            _cell2(content: 'invoice_number', showDivider: true),
            _cell2(content: 'EGP', showDivider: false),
            _cell2(content: 'invoice_type', showDivider: true),
            _cell2(content: '4898', showDivider: false),
            _cell2(content: 'financial_unit', showDivider: true),
          ],
        ),
        pw.TableRow(
          children: [
            _cell2(content: '4898', showDivider: false),
            _cell2(content: 'currency', showDivider: true),
            _cell2(content: 'EGP', showDivider: false),
            _cell2(content: 'time', showDivider: true),
            _cell2(content: '10:24:21', showDivider: false),
            _cell2(content: 'invoice_date', showDivider: true),
          ],
        ),
        pw.TableRow(
          children: [
            _cell2(content: '4898', showDivider: false),
            _cell2(content: 'payment_method', showDivider: true),
            _cell2(content: 'EGP', showDivider: false),
            _cell2(content: 'phone_number', showDivider: true),
            _cell2(content: '10:24:21', showDivider: false),
            _cell2(content: 'client_number', showDivider: true),
          ],
        ),
        pw.TableRow(
          children: [
            _cell2(content: '', showDivider: false),
            _cell2(content: '', showDivider: false),
            _cell2(content: 'EGP', showDivider: false),
            _cell2(content: 'cash_register_number', showDivider: true),
            _cell2(content: '10:24:21', showDivider: false),
            _cell2(content: 'amount', showDivider: true),
          ] ,
        ),
      ],
    );
  }
  pw.Widget _cell2({required String content, required bool showDivider}) {
    return pw.Container(
      margin: pw.EdgeInsets.only(top: 5, left: showDivider ? 0 : 3),
      color: PdfColor.fromHex("#EBF8FF"),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: pw.CrossAxisAlignment.center, // Ensures alignment
        children: [
          pw.SizedBox(
              width: 60,
              child: pw.Text(content, style: const pw.TextStyle(fontSize: 8))),
          showDivider
              ? pw.Container(
                  height:
                      8, // Adjust this height based on the desired widget height
                  child: pw.VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: const PdfColorGrey(0.5),
                  ),
                )
              : pw.SizedBox(),
        ],
      ),
    );
  }
