/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsEnvGen {
  const $AssetsEnvGen();

  /// File path: assets/env/.env.git_information
  String get envGitInformation => 'assets/env/.env.git_information';

  /// File path: assets/env/.env.production
  String get envProduction => 'assets/env/.env.production';

  /// File path: assets/env/.env.stagging
  String get envStagging => 'assets/env/.env.stagging';

  /// File path: assets/env/.env.uat
  String get envUat => 'assets/env/.env.uat';

  /// List of all assets
  List<String> get values =>
      [envGitInformation, envProduction, envStagging, envUat];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesErrorGen get error => const $AssetsImagesErrorGen();
  $AssetsImagesIconGen get icon => const $AssetsImagesIconGen();
  $AssetsImagesSignInGen get signIn => const $AssetsImagesSignInGen();
}

class $AssetsImagesErrorGen {
  const $AssetsImagesErrorGen();

  /// File path: assets/images/error/Image_Error.png
  AssetGenImage get imageError =>
      const AssetGenImage('assets/images/error/Image_Error.png');

  /// File path: assets/images/error/image_data_note_exist.png
  AssetGenImage get imageDataNoteExist =>
      const AssetGenImage('assets/images/error/image_data_note_exist.png');

  /// List of all assets
  List<AssetGenImage> get values => [imageError, imageDataNoteExist];
}

class $AssetsImagesIconGen {
  const $AssetsImagesIconGen();

  /// File path: assets/images/icon/Check.svg
  String get check => 'assets/images/icon/Check.svg';

  /// File path: assets/images/icon/Close Square.svg
  String get closeSquare => 'assets/images/icon/Close Square.svg';

  /// File path: assets/images/icon/Icon_dark.svg
  String get iconDark => 'assets/images/icon/Icon_dark.svg';

  /// File path: assets/images/icon/Icon_night.svg
  String get iconNight => 'assets/images/icon/Icon_night.svg';

  /// File path: assets/images/icon/Loading.json
  String get loading => 'assets/images/icon/Loading.json';

  /// File path: assets/images/icon/Lock.svg
  String get lock => 'assets/images/icon/Lock.svg';

  /// File path: assets/images/icon/circular_progress_indicator.png
  AssetGenImage get circularProgressIndicator =>
      const AssetGenImage('assets/images/icon/circular_progress_indicator.png');

  /// File path: assets/images/icon/person.svg
  String get person => 'assets/images/icon/person.svg';

  /// List of all assets
  List<dynamic> get values => [
        check,
        closeSquare,
        iconDark,
        iconNight,
        loading,
        lock,
        circularProgressIndicator,
        person
      ];
}

class $AssetsImagesSignInGen {
  const $AssetsImagesSignInGen();

  /// File path: assets/images/sign_in/Background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/sign_in/Background.png');

  /// File path: assets/images/sign_in/Logo.png
  AssetGenImage get logo =>
      const AssetGenImage('assets/images/sign_in/Logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [background, logo];
}

class Assets {
  Assets._();

  static const $AssetsEnvGen env = $AssetsEnvGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
