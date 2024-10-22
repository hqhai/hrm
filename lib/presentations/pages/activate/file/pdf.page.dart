import 'dart:async';
import 'dart:io';

import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:themes/themes.dart';
import 'package:http/http.dart' as http;

final pDFPageRoute = GoRoute(
    path: Pages.pDFPage,
    name: Pages.pDFPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return PDFPage(
        url: data['url'],
        checkLocal: data['checkLocal'],
      );
    });

class PDFPage extends StatefulWidget {
  const PDFPage({
    super.key,
    required this.url,
    required this.checkLocal,
  });

  final String url;
  final bool checkLocal;

  @override
  State<PDFPage> createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  late Completer<PDFViewController> _controller;

  @override
  void initState() {
    _controller = Completer<PDFViewController>();
    super.initState();
  }

  Future<File> _fileFromImageUrl() async {
    if(widget.checkLocal){
      return File(widget.url);
    }
    final response = await http.get(Uri.parse(widget.url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentDirectory.path}/meo_an_url.pdf';
    final fileLoad = File(filePath);
    fileLoad.writeAsBytesSync(response.bodyBytes);
    return fileLoad;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.pdf),
      ),
      body: FutureBuilder<File>(
        future: _fileFromImageUrl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
            );
          } else if (snapshot.hasError) {
            return Container(
              color: colors.error,
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: Lottie.asset(
                Assets.gif.loading,
                height: 150,
                width: 150,
              ),
            );
          }
        },
      ),
    );
  }
}
