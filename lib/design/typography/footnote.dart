import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';

class IonTextStyleFootNote extends IonTextStyle {
  final IonBodyFontSizeHeight ionFontSize;
  final IonTextColor ionTextColor;
  const IonTextStyleFootNote({
    required super.ionFontWeight,
    required super.ionFontStyle,
    this.ionFontSize = IonBodyFontSizeHeight.regular,
    this.ionTextColor = IonTextColor.neutral8,
  });

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize.sp;

  @override
  Color? get color => IonMainColors.neutral6;
}

enum IonFootNoteFontSizeHeight {
  regular(12, 1.333),
  large(14, 1.428);

  final double fontSize;
  final double height;

  const IonFootNoteFontSizeHeight(this.fontSize, this.height);
}
