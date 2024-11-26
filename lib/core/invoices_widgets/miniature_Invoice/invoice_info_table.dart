import 'package:flutter/material.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceInfoTable(BuildContext bcontext, pw.TextDirection dir) {
  List<pw.TableRow> infoList = [
    pw.TableRow(
      children: [
        _cell(content: '10:24:21', showDivider: false),
        _cell(content: 'invoice_number', showDivider: true),
        _cell(content: '4898', showDivider: false),
        _cell(content: 'payment_method', showDivider: true),
      ].reversed.toList(),
    ),
    pw.TableRow(
      children: [
        _cell(content: 'EGP', showDivider: false),
        _cell(content: 'time', showDivider: true),
        _cell(content: '10:24:21', showDivider: false),
        _cell(content: 'invoice_date', showDivider: true),
      ],
    ),
    pw.TableRow(
      children: [
        _cell(content: 'EGP', showDivider: false),
        _cell(content: 'point_number', showDivider: true),
        _cell(content: '10:24:21', showDivider: false),
        _cell(content: 'cashier', showDivider: true),
      ],
    ),
  ];

  return pw.Table(
      border: const pw.TableBorder(
        top: pw.BorderSide.none,
        bottom: pw.BorderSide.none,
        left: pw.BorderSide.none,
        right: pw.BorderSide.none,
        horizontalInside: pw.BorderSide.none,
        verticalInside: pw.BorderSide.none,
      ),
      children: dir == pw.TextDirection.rtl
          ? infoList
          : infoList.reversed.map(
              (e) {
                return pw.TableRow(children: e.children.reversed.toList());
              },
            ).toList());
}

pw.Widget _cell({required String content, required bool showDivider}) {
  return pw.Container(
    margin: pw.EdgeInsets.only(top: 5, left: showDivider ? 0 : 3),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: pw.CrossAxisAlignment.center, // Ensures alignment
      children: [
        pw.SizedBox(
            width: 60,
            child: pw.Text(content,
                style: pw.TextStyle(
                    fontSize: 8,
                    color: showDivider ? PdfColor.fromHex("#0C69C0") : null))),
      ],
    ),
  );
}
