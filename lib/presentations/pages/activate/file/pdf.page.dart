import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';

final pDFPageRoute = GoRoute(
    path: Pages.pDFPage,
    name: Pages.pDFPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return PDFPage(
        url: data['url'],
      );
    });

class PDFPage extends StatelessWidget {
  const PDFPage({super.key, required this.url,});

  final String url;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.pdf),
      ),
      body: PDFView(filePath: url,)
    );
  }
}
