import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

/// A4 landscape certificate for a verified achievement, worded in the
/// current language and set in the bundled Inter font.
Future<Uint8List> buildCertificatePdf(AppLocalization l10n,
    {required Achievement achievement, required String recipientName}) async {
  Future<pw.Font> font(String file) async =>
      pw.Font.ttf(await rootBundle.load('assets/fonts/$file'));
  final regular = await font('Inter-Regular.ttf');
  final bold = await font('Inter-Bold.ttf');
  final extraBold = await font('Inter-ExtraBold.ttf');
  final italic = await font('Inter-Italic.ttf');

  final tier = achievement.tier;
  final accent = PdfColor.fromInt(tier.colors.first.toARGB32());
  const ink = PdfColor.fromInt(0xFF1A1A19);
  const muted = PdfColor.fromInt(0xFF6E6B65);

  final document =
      pw.Document(title: achievement.name, author: achievement.company);
  document.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4.landscape,
    theme: pw.ThemeData.withFont(
        base: regular, bold: bold, italic: italic, boldItalic: bold),
    build: (context) => pw.Container(
      decoration:
          pw.BoxDecoration(border: pw.Border.all(color: accent, width: 3)),
      padding: const pw.EdgeInsets.all(6),
      child: pw.Container(
        decoration:
            pw.BoxDecoration(border: pw.Border.all(color: accent, width: 0.8)),
        padding: const pw.EdgeInsets.fromLTRB(48, 36, 48, 32),
        child: pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('SCOREBOARD',
                    style: pw.TextStyle(
                        font: bold,
                        fontSize: 10,
                        letterSpacing: 2,
                        color: muted)),
                pw.Text(achievement.company ?? '',
                    style: pw.TextStyle(font: bold, fontSize: 11, color: ink)),
              ],
            ),
            pw.Spacer(),
            pw.Text(l10n.certTitle,
                style: pw.TextStyle(
                    font: bold, fontSize: 13, letterSpacing: 4, color: accent)),
            pw.SizedBox(height: 26),
            pw.Text(l10n.certPresentedTo,
                style: const pw.TextStyle(fontSize: 13, color: muted)),
            pw.SizedBox(height: 8),
            pw.Text(recipientName,
                style: pw.TextStyle(font: extraBold, fontSize: 38, color: ink)),
            pw.SizedBox(height: 14),
            pw.Text(l10n.certHasEarned,
                style: const pw.TextStyle(fontSize: 13, color: muted)),
            pw.SizedBox(height: 8),
            pw.Text(achievement.name ?? '',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(font: bold, fontSize: 28, color: ink)),
            pw.SizedBox(height: 10),
            pw.ConstrainedBox(
              constraints: const pw.BoxConstraints(maxWidth: 460),
              child: pw.Text(achievement.description ?? '',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      font: italic,
                      fontSize: 12,
                      color: muted,
                      lineSpacing: 3)),
            ),
            pw.SizedBox(height: 14),
            pw.Text(
                '${tier.localized(l10n)} · ${l10n.xpValue(achievement.points ?? 0)}',
                style: pw.TextStyle(font: bold, fontSize: 12, color: accent)),
            pw.Spacer(),
            pw.Container(
                height: 0.6, color: const PdfColor.fromInt(0xFFE3E0D9)),
            pw.SizedBox(height: 12),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                    l10n.certIssuedBy(achievement.company ?? '',
                        formatDate(achievement.date)),
                    style: const pw.TextStyle(fontSize: 10.5, color: ink)),
                pw.Text(l10n.certCredentialId(achievement.id ?? '-'),
                    style: const pw.TextStyle(fontSize: 9, color: muted)),
              ],
            ),
          ],
        ),
      ),
    ),
  ));
  return document.save();
}
