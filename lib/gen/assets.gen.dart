/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  static const AssetGenImage eNGAbbriviationFullColor = AssetGenImage(
    'assets/ENG-Abbriviation-FullColor.png',
  );
  static const AssetGenImage eNGAbbriviationGreyscaleGrey = AssetGenImage(
    'assets/ENG-Abbriviation-Greyscale-Grey.png',
  );
  static const AssetGenImage eNGAbbriviationGreyscaleWhite = AssetGenImage(
    'assets/ENG-Abbriviation-Greyscale-White.png',
  );
  static const AssetGenImage eNGHorizontalFullColor = AssetGenImage(
    'assets/ENG-Horizontal-FullColor.png',
  );
  static const AssetGenImage book0 = AssetGenImage('assets/book0.png');
  static const AssetGenImage book1 = AssetGenImage('assets/book1.png');
  static const AssetGenImage book2 = AssetGenImage('assets/book2.png');
  static const AssetGenImage book3 = AssetGenImage('assets/book3.png');
  static const AssetGenImage book4 = AssetGenImage('assets/book4.png');
  static const AssetGenImage book5 = AssetGenImage('assets/book5.png');
  static const AssetGenImage book6 = AssetGenImage('assets/book6.png');
  static const AssetGenImage book7 = AssetGenImage('assets/book7.png');
  static const String bot = 'assets/bot.svg';
  static const AssetGenImage branding = AssetGenImage('assets/branding.png');
  static const AssetGenImage brandingDark = AssetGenImage(
    'assets/branding_dark.png',
  );
  static const AssetGenImage certificate = AssetGenImage(
    'assets/certificate.png',
  );
  static const AssetGenImage checklist2929022 = AssetGenImage(
    'assets/checklist_2929022.png',
  );
  static const AssetGenImage dropdown18573523 = AssetGenImage(
    'assets/dropdown_18573523.png',
  );
  static const AssetGenImage folder = AssetGenImage('assets/folder.png');
  static const AssetGenImage googleLogo = AssetGenImage(
    'assets/google_logo.png',
  );
  static const AssetGenImage image1 = AssetGenImage('assets/image1.png');
  static const AssetGenImage image2 = AssetGenImage('assets/image2.png');
  static const AssetGenImage image3 = AssetGenImage('assets/image3.png');
  static const AssetGenImage koket = AssetGenImage('assets/koket.png');
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');
  static const AssetGenImage logo12dark = AssetGenImage(
    'assets/logo12dark.png',
  );
  static const AssetGenImage logo12light = AssetGenImage(
    'assets/logo12light.png',
  );
  static const AssetGenImage onboard1 = AssetGenImage('assets/onboard1.png');
  static const AssetGenImage onboarding1 = AssetGenImage(
    'assets/onboarding1.png',
  );
  static const AssetGenImage poweredByKoketDark = AssetGenImage(
    'assets/powered_by_koket_dark.png',
  );
  static const AssetGenImage poweredByKoketLight = AssetGenImage(
    'assets/powered_by_koket_light.png',
  );
  static const String send = 'assets/send.svg';
  static const AssetGenImage ship = AssetGenImage('assets/ship.png');
  static const AssetGenImage students = AssetGenImage('assets/students.png');
  static const AssetGenImage user = AssetGenImage('assets/user.png');
  static const AssetGenImage wheel = AssetGenImage('assets/wheel.png');

  /// List of all assets
  static List<dynamic> get values => [
    eNGAbbriviationFullColor,
    eNGAbbriviationGreyscaleGrey,
    eNGAbbriviationGreyscaleWhite,
    eNGHorizontalFullColor,
    book0,
    book1,
    book2,
    book3,
    book4,
    book5,
    book6,
    book7,
    bot,
    branding,
    brandingDark,
    certificate,
    checklist2929022,
    dropdown18573523,
    folder,
    googleLogo,
    image1,
    image2,
    image3,
    koket,
    logo,
    logo12dark,
    logo12light,
    onboard1,
    onboarding1,
    poweredByKoketDark,
    poweredByKoketLight,
    send,
    ship,
    students,
    user,
    wheel,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
