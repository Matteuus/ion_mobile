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
  semibold(FontWeight.w500), //semibold não está disponível no design system
  medium(FontWeight.w600),
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

enum IonTextColor {
  neutral8(IonMainColors.neutral8),
  neutral7(IonMainColors.neutral7),
  neutral6(IonMainColors.neutral6),
  neutral1(IonMainColors.neutral1),
  primary6(IonMainColors.primary6),
  negative6(IonIndicativeColors.negative6),
  primary7(IonMainColors.primary7),
  negative7(IonIndicativeColors.negative7),

  //disabled
  neutral5(IonMainColors.neutral5);

  final Color color;

  const IonTextColor(this.color);
}
