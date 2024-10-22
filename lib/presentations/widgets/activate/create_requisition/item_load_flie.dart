import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/image_dialog/image_dialog.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String error = '';

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
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x4, bottom: SpacingUnit.x2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.attachedFiles,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w800,
                ),
              ),
              InkWell(
                onTap: () => _getFile(),
                child: SvgPicture.asset(
                  Assets.images.icon.activateIcon.loadFile,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
        if (setOldFiles().isNotEmpty)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: setOldFiles()
                .mapIndexed((index, element) => InkWell(
                      onTap: () => _onClickFLie(context, index),
                      child: ContainerBorder(
                        borderColors: colors.text.withOpacity(0.3),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x0_5),
                              child: SvgPicture.asset(
                                Assets.images.icon.activateIcon.fileAttach,
                                colorFilter: ColorFilter.mode(
                                  colors.text.withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                files[index].path.split('/').last,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x3,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x0_5),
                              child: InkWell(
                                onTap: () => _deleteFile(index),
                                child: Icon(
                                  size: SpacingUnit.x6,
                                  Icons.cancel,
                                  color: colors.text.withOpacity(0.5),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        if (paths.length > 5)
          Text(
            appLocalizations.limitFile,
            style: TextStyle(
              fontSize: SpacingUnit.x3,
              color: colors.error,
            ),
          ),
        const SizedBox(
          height: SpacingUnit.x4,
        ),
      ],
    );
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
    Map<Permission, PermissionStatus> statuses = Platform.isIOS
        ? await [
            Permission.storage,
          ].request()
        : await [
            Permission.storage,
          ].request();
    if (statuses.containsValue(PermissionStatus.permanentlyDenied) ||
        statuses.containsValue(PermissionStatus.denied)) {
      await openAppSettings();
      return;
    }
    if (files.length <= 5) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
      );

      if (result != null) {
        const maxFile = 1024 * 2 * 1024;
        final checkFile = result.files.where((e) => e.size < maxFile);
        final dataPaths = checkFile.map((e) => e.path ?? '').toList();
        setState(() {
          files.addAll(dataPaths.map((e) => File(e)).toList());
          paths.addAll(dataPaths);
          widget.onChangeFiles?.call(files);
        });
      } else {
        setState(() {
          files = [];
          paths = [];
        });
      }
    }
  }

  _onClickFLie(BuildContext context, int index) {
    if (_checkTypeFile(index)) {
      dI<AppNavigation>()
          .pushName(context, page: Pages.pDFPage, extra: {'url': paths[index], 'checkLocal': true});
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ImageLocalDialog(
              file: files[index],
            ),
          );
        },
      );
    }
  }

  _deleteFile(int index) {
    setState(() {
      files.removeAt(index);
      paths.removeAt(index);
    });
  }
}
