import 'package:flutter/material.dart';
import 'package:onix_bot/core/customButton.dart';
import 'package:onix_bot/core/style/app_colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// import 'package:onyx_ix/lib/core/src/app_export.dart';
class PreviewScreen extends StatelessWidget {
  final pw.Document doc;
  final double? width;
  final double? height;
  const PreviewScreen({
    super.key,
    required this.doc,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: Colors.transparent,
      content: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: PdfPreview(
          build: (format) => doc.save(),
          actionBarTheme: const PdfActionBarTheme(
            backgroundColor: whiteColor,
            iconColor: kCardGreenColor,
          ),
          allowSharing: false,
          canDebug: false,
          canChangePageFormat: false,
          canChangeOrientation: false,
          allowPrinting: false,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "invoice.pdf",
          actions: [
            CustomButton(
              icon: const Icon(
                Icons.print,
                color: whiteColor,
                size: 16,
              ),
              circularRadius: 5,
              bgcColor: kCardGreenColor,
              title: 'print',
              textColor: whiteColor,
              width: 80,
              onPressed: () async {
                Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
                  return doc.save();
                });
              },
            ),
            CustomButton(
              circularRadius: 5,
              bgcColor: gray100Text,
              title: 'close',
              textColor: whiteColor,
              width: 80,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// To show this dialog:
void showPreviewDialog(BuildContext context, pw.Document doc,
    [double? width, double? height]) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PreviewScreen(
        doc: doc,
        height: height,
        width: width,
      );
    },
  );
}
