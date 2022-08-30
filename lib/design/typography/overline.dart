import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';

class IonTextStyleOverline extends IonTextStyle {
  final IonBodyFontSizeHeight ionFontSize;
  const IonTextStyleOverline({
    required super.ionFontWeight,
    this.ionFontSize = IonBodyFontSizeHeight.regular,
  }) : super(ionFontStyle: IonFontStyle.normal);

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize.sp;

  @override
  Color? get color => IonMainColors.neutral6;
}

enum IonOverlineFontSizeHeight {
  regular(12, 1.333),
  large(14, 1.428);

  final double fontSize;
  final double height;

  const IonOverlineFontSizeHeight(this.fontSize, this.height);
}
