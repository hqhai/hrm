import 'dart:io';

import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
        return Container(
          padding: const EdgeInsets.all(SpacingUnit.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x2),
            color: CustomsColor.colorBackground,
            border: Border.all(
              color: colors.text,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    _image(state),
                    if (widget.isCheck == true)
                      GestureDetector(
                        onTap: () => getImagePath(),
                        child:
                            Icon(Icons.photo_camera, color: colors.tertiary, size: SpacingUnit.x7),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: SpacingUnit.x4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.fullName ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                      ),
                      const SizedBox(height: SpacingUnit.x5),
                      Row(
                        children: [
                          Text(
                            '${appLocalizations.phoneNumber} : ',
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                          ),
                          Expanded(
                            child: Text(
                              state.user.phoneNumber ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: SpacingUnit.x1_5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${appLocalizations.email} : ',
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                          ),
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              state.user.email ?? "",
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool _checkPathImage(UserState state) {
    return state.user.avatarPath?.isNotEmpty == true && pathImage == '';
  }

  Widget _image(UserState state) {
    if (_checkPathImage(state)) {
      return SizedBox(
        child: Image.network(
          state.user.avatarPath ?? "",
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              Assets.images.error.imageError.path,
              fit: BoxFit.fill,
            );
          },
        ),
      );
    } else {
      if (pathImage != '') {
        return SizedBox(
          child: Image.file(
            File(pathImage),
            fit: BoxFit.fill,
          ),
        );
      } else {
        return const SizedBox();
      }
    }
  }

  Future<void> getImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pathImage = pickedFile.path;
        file = File(pathImage);
      });
      widget.onChange?.call(file);
    } else {
      pathImage = '';
    }
  }
}
