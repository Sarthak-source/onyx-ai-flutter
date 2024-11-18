import 'package:flutter/material.dart';
import 'package:onix_bot/core/localizations/app_localization.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget invoiceSummary(BuildContext bcontext, pw.TextDirection dir) {
  return pw.Directionality(textDirection: pw.TextDirection.rtl, child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _summaryRowa(
          'number_of_items'.tr(bcontext),
          '6',dir
        ),
        //  pw.Container(
        //       width: 100,
        //       child: pw.Divider(thickness: 0.5, color: const PdfColorGrey(0.3))),
        _summaryRowa('total'.tr(bcontext), '1200',dir),
        _summaryRowa('tax'.tr(bcontext), '200',dir),
        _summaryRowa('net_total'.tr(bcontext), '1400',dir),
        _summaryRowa('amount_paid'.tr(bcontext), '1400',dir),
        _summaryRowa('remaining_balance'.tr(bcontext), '0.00',dir),
      ],
    )
  ]),);
}

pw.Widget _summaryRowa(String label, String value,pw.TextDirection dir) {
  return pw.Column(crossAxisAlignment:dir==pw.TextDirection.rtl? pw.CrossAxisAlignment.start:pw.CrossAxisAlignment.end, children: [
   pw.Directionality(textDirection: dir, child:  pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
            width: 70,
            child: pw.Text(label, style: const pw.TextStyle(fontSize: 8))),
        // pw.SizedBox(width: 20),
        pw.Text(value, style: const pw.TextStyle(fontSize: 8)),
      ],
    ),),
    pw.Container(
        width: 130,
        child: pw.Divider(
            borderStyle: pw.BorderStyle.dotted,
            thickness: 0.2,
            color: const PdfColorGrey(0.3)))
  ]);
}
