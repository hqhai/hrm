import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemLoadFile extends StatefulWidget {
  const ItemLoadFile({super.key, this.onChangeFiles, this.files = const []});

  final ValueChanged<List<File>>? onChangeFiles;
  final List<File> files;

  @override
  State<ItemLoadFile> createState() => _ItemLoadFileState();
}

class _ItemLoadFileState extends State<ItemLoadFile> {
  late List<File> files = [];
  late List<String> paths = [];

  List<File> setOldFiles() {
    setState(() {
      if (widget.files.isNotEmpty && paths.isEmpty) {
        files = widget.files;
      }
    });
    return files;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.attachedFiles,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        GestureDetector(
          onTap: () => _getFile(),
          child: Container(
            height: SpacingUnit.x15,
            width: SpacingUnit.x15,
            margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            padding: const EdgeInsets.all(SpacingUnit.x3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SpacingUnit.x1),
              color: colors.background,
              border: Border.all(color: colors.text, width: 1),
            ),
            child: SvgPicture.asset(
              Assets.images.icon.activateIcon.fileAttach,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
          ),
        ),
        if (setOldFiles().isNotEmpty)
          SizedBox(
            height: width * widthListFile(),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: SpacingUnit.x10,
              ),
              itemCount: setOldFiles().length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _onClickFLie(context, index),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x1),
                    color: colors.background,
                    border: Border.all(color: colors.text, width: 1),
                  ),
                  child: _checkTypeFile(index)
                      ? Center(
                          child: Text(
                            appLocalizations.pdf,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x7,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      : Image.file(
                          files[index],
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) => Image.network(
                            files[index].path,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              Assets.images.error.imageError.path,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          )
      ],
    );
  }

  double widthListFile() {
    if (files.length > 3) {
      return 0.35 * (files.length / 3).toDouble();
    } else {
      return 0.35;
    }
  }

  bool _checkTypeFile(int index) {
    int length = files[index].path.length;
    String type = files[index].path.substring(length - 3, length);
    if (type == 'pdf' || type == 'PDF') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path ?? "")).toList();
        paths = result.paths.map((path) => path.toString()).toList();
        widget.onChangeFiles?.call(files);
      });
    } else {
      setState(() {
        files = [];
        paths = [];
      });
    }
  }

  _onClickFLie(BuildContext context, int index) {
    if (_checkTypeFile(index)) {
      dI<AppNavigation>().pushName(context, page: Pages.pDFPage, extra: {
        'url': paths[index],
      });
    } else {}
  }
}
