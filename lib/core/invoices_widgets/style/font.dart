import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

abstract class PWAppTextStyles {
  static Future<pw.TextStyle> getDefaultTextStyle() async {
    final font = await PdfGoogleFonts.cairoPlayRegular();
    // final pw.Font regularFont = await loadFont('fold/fonts/Cairo-Regular.ttf');
    return pw.TextStyle(
      font: font,
      fontSize: 8,
      fontWeight: pw.FontWeight.normal,
    );
  }


}
