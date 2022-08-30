import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/typography.dart';

class IonTextStyleBody extends IonTextStyle {
  final IonBodyFontSizeHeight ionFontSize;
  final IonBodyColor ionBodyColor;
  const IonTextStyleBody({
    required super.ionFontWeight,
    required super.ionFontStyle,
    this.ionFontSize = IonBodyFontSizeHeight.regular,
    this.ionBodyColor = IonBodyColor.neutral8,
  });

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize.sp;

  @override
  Color? get color => ionBodyColor.color;
}

enum IonBodyFontSizeHeight {
  regular(14, 1.428),
  large(16, 1.5);

  final double fontSize;
  final double height;

  const IonBodyFontSizeHeight(this.fontSize, this.height);
}
