import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';

const String _fontFamily = 'Source Sans Pro';

abstract class IonTextStyle extends TextStyle {
  final String ionFontFamily = _fontFamily;

  final IonFontStyle ionFontStyle;
  final IonFontWeight ionFontWeight;

  const IonTextStyle({required this.ionFontWeight, required this.ionFontStyle});

  @override
  String? get fontFamily => ionFontFamily;

  @override
  FontWeight? get fontWeight => ionFontWeight.fontWeight;

  @override
  FontStyle? get fontStyle => ionFontStyle.fontStyle;
}

enum IonFontWeight {
  regular(FontWeight.w400),
  semibold(FontWeight.w500),
  bold(FontWeight.w700);

  final FontWeight fontWeight;

  const IonFontWeight(this.fontWeight);
}

enum IonFontStyle {
  normal(FontStyle.normal),
  italic(FontStyle.italic);

  final FontStyle fontStyle;

  const IonFontStyle(this.fontStyle);
}

enum IonBodyColor {
  neutral8(IonMainColors.neutral8),
  neutral7(IonMainColors.neutral7),
  neutral1(IonMainColors.neutral1),
  primary6(IonMainColors.primary6);

  final Color color;

  const IonBodyColor(this.color);
}
