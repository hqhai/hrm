import 'dart:io';

import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:themes/themes.dart';

class ItemProfile extends StatefulWidget {
  const ItemProfile({super.key, this.isCheck, this.onChange});

  final bool? isCheck;
  final ValueChanged<File>? onChange;

  @override
  State<ItemProfile> createState() => _ItemProfileState();
}

class _ItemProfileState extends State<ItemProfile> {
  late String pathImage;
  late File file;

  @override
  void initState() {
    super.initState();
    pathImage = '';
    file = File('');
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return ContainerBorder(
          marginTop: 0,
          borderColors: colors.background,
          backgroundColors: colors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _image(state),
                    if (widget.isCheck == true)
                      GestureDetector(
                        onTap: () => getImagePath(),
                        child: ContainerBorder(
                          circular: SpacingUnit.x10,
                          backgroundColors: colors.onSurface,
                          borderColors: colors.onSurface,
                          paddingVertical: SpacingUnit.x1,
                          marginTop: 0,
                          child: Icon(
                            Icons.photo_camera_outlined,
                            color: colors.blue,
                            size: SpacingUnit.x6,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${appLocalizations.employeeCode} : ',
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3_5,
                    ),
                  ),
                  Text(
                    state.user.code,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3_5,
                    ),
                  ),
                ],
              ),
              Text(
                state.user.fullName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4_5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _checkPathImage(UserState state) {
    return state.user.avatarPath.isNotEmpty == true && pathImage == '';
  }

  Widget _image(UserState state) {
    if (_checkPathImage(state)) {
      return SizedBox(
        height: SpacingUnit.x25,
        width: SpacingUnit.x25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SpacingUnit.x25),
          child: Image.network(
            state.user.avatarPath,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                Assets.images.error.imageError.path,
                fit: BoxFit.fill,
              );
            },
          ),
        ),
      );
    } else {
      if (pathImage != '') {
        return SizedBox(
          height: SpacingUnit.x25,
          width: SpacingUnit.x25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SpacingUnit.x25),
            child: Image.file(
              File(pathImage),
              fit: BoxFit.fill,
              height: SpacingUnit.x25,
              width: SpacingUnit.x25,
            ),
          ),
        );
      } else {
        return SizedBox(
          height: SpacingUnit.x25,
          width: SpacingUnit.x25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SpacingUnit.x25),
            child: Image.asset(
              Assets.images.error.imageError.path,
              fit: BoxFit.fill,
              height: SpacingUnit.x25,
              width: SpacingUnit.x25,
            ),
          ),
        );
      }
    }
  }

  Future<void> getImagePath() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    PermissionStatus? storagePermission;
    PermissionStatus? photoPermission;
    if (int.parse(androidDeviceInfo.version.release) < 13) {
      storagePermission = await Permission.storage.request();
    } else {
      photoPermission = await Permission.photos.request();
    }
    if ((photoPermission != null &&
        (photoPermission == PermissionStatus.permanentlyDenied ||
            photoPermission == PermissionStatus.denied)) ||
        (storagePermission != null &&
            (storagePermission == PermissionStatus.permanentlyDenied ||
                storagePermission == PermissionStatus.denied))) {
      await openAppSettings();
    } else {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          pathImage = pickedFile.path;
          file = File(pathImage);
        });
        widget.onChange?.call(file);
      }
    }
  }
}
