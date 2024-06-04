import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemLoadFile extends StatefulWidget {
  const ItemLoadFile({super.key, this.onChangeFiles});

  final ValueChanged<List<File>>? onChangeFiles;

  @override
  State<ItemLoadFile> createState() => _ItemLoadFileState();
}

class _ItemLoadFileState extends State<ItemLoadFile> {
  late File file;

  @override
  Widget build(BuildContext context) {
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
              color: colors.surface,
              border: Border.all(color: colors.text, width: 1),
            ),
            child: SvgPicture.asset(
              Assets.images.icon.activateIcon.fileAttach,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      setState(() {
        file = File.fromRawPath(result.files.first.bytes!);
      });
    } else {
      setState(() {
        file = File('');
      });
    }
  }
}
