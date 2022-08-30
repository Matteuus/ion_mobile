import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography/text_style.dart';

class IonTextStyleH1 extends IonTextStyle {
  final IonH1FontSizeHeight ionFontSize;

  const IonTextStyleH1({
    required IonFontWeight ionFontWeight,
    this.ionFontSize = IonH1FontSizeHeight.regular,
  }) : super(
          ionFontWeight: ionFontWeight,
          ionFontStyle: IonFontStyle.normal,
        );

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize;

  @override
  Color? get color => IonMainColors.neutral8;
}

class IonTextStyleH2 extends IonTextStyle {
  final IonH2FontSizeHeight ionFontSize;

  const IonTextStyleH2({
    required IonFontWeight ionFontWeight,
    this.ionFontSize = IonH2FontSizeHeight.regular,
  }) : super(
          ionFontWeight: ionFontWeight,
          ionFontStyle: IonFontStyle.normal,
        );

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize;

  @override
  Color? get color => IonMainColors.neutral8;
}

class IonTextStyleH3 extends IonTextStyle {
  final IonH3FontSizeHeight ionFontSize;

  const IonTextStyleH3({
    required IonFontWeight ionFontWeight,
    this.ionFontSize = IonH3FontSizeHeight.regular,
  }) : super(
          ionFontWeight: ionFontWeight,
          ionFontStyle: IonFontStyle.normal,
        );

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize;

  @override
  Color? get color => IonMainColors.neutral8;
}

class IonTextStyleH4 extends IonTextStyle {
  final IonH4FontSizeHeight ionFontSize;

  const IonTextStyleH4({
    required IonFontWeight ionFontWeight,
    this.ionFontSize = IonH4FontSizeHeight.regular,
  }) : super(
          ionFontWeight: ionFontWeight,
          ionFontStyle: IonFontStyle.normal,
        );

  @override
  double? get height => ionFontSize.height;

  @override
  double? get fontSize => ionFontSize.fontSize.sp;

  @override
  Color? get color => IonMainColors.neutral8;
}

enum IonH1FontSizeHeight {
  regular(40, 1.2),
  medium(32, 1.25),
  small(24, 1.333);

  final double fontSize;
  final double height;

  const IonH1FontSizeHeight(this.fontSize, this.height);
}

enum IonH2FontSizeHeight {
  regular(32, 1.25),
  medium(24, 1.333),
  small(20, 1.4);

  final double fontSize;
  final double height;

  const IonH2FontSizeHeight(this.fontSize, this.height);
}

enum IonH3FontSizeHeight {
  regular(24, 1.333),
  medium(20, 1.4),
  small(16, 1.5);

  final double fontSize;
  final double height;

  const IonH3FontSizeHeight(this.fontSize, this.height);
}

enum IonH4FontSizeHeight {
  regular(20, 1.4),
  medium(18, 1.5),
  small(16, 1.5);

  final double fontSize;
  final double height;

  const IonH4FontSizeHeight(this.fontSize, this.height);
}
