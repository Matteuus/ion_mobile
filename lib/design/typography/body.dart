import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/typography.dart';

class IonTextStyleBody extends IonTextStyle {
  final IonBodyFontSizeHeight ionFontSize;
  final IonTextColor ionTextColor;
  const IonTextStyleBody({
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
  Color? get color => ionTextColor.color;
}

enum IonBodyFontSizeHeight {
  regular(14, 1.428),
  large(16, 1.5),
  small(12, 1.4);

  final double fontSize;
  final double height;

  const IonBodyFontSizeHeight(this.fontSize, this.height);
}
