import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';

abstract class IonButtonColor {
  void setColors({required bool isDanger});
}

class IonButtonPrimaryColors implements IonButtonColor {
  // unHover e onTapUp são o color;
  final bool isDanger;
  Color color = IonMainColors.primary6;
  IonTextColor textColor = IonTextColor.neutral1;
  Color iconColor = IonMainColors.neutral1;
  Color onHover = IonMainColors.primary5;
  Color onTapDown = IonMainColors.primary7;

  IonButtonPrimaryColors(this.isDanger) {
    setColors(isDanger: isDanger);
  }

  @override
  void setColors({required bool isDanger}) {
    color = isDanger ? IonIndicativeColors.negative6 : IonMainColors.primary6;
    onHover = isDanger ? IonIndicativeColors.negative5 : IonMainColors.primary5;
    onTapDown =
        isDanger ? IonIndicativeColors.negative7 : IonMainColors.primary7;
  }
}

class IonButtonSecundaryColors implements IonButtonColor {
  final bool isDanger;
  Color color = IonMainColors.neutral1;
  IonTextColor textColor = IonTextColor.primary6;
  Color borderColor = IonMainColors.neutral4;
  Color iconColor = IonMainColors.primary6;
  Color onHoverColor = IonMainColors.primary1;
  Color onHoverBorderColor = IonMainColors.primary3;
  Color onTapDownColor = IonMainColors.primary2;
  Color onTapDownBorderColor = IonMainColors.primary80;
  IonTextColor onTapDownTextColor = IonTextColor.primary7;
  Color onTapDownIconColor = IonMainColors.primary7;
  List<Color> gradientColors = [
    IonMainColors.primary6,
    IonMainColors.primary5,
    IonMainColors.primary4,
    IonMainColors.primary3,
  ];

  IonButtonSecundaryColors(this.isDanger) {
    setColors(isDanger: isDanger);
  }

  @override
  void setColors({required bool isDanger}) {
    textColor = isDanger ? IonTextColor.negative6 : IonTextColor.primary6;
    gradientColors = isDanger
        ? [
            IonIndicativeColors.negative6,
            IonIndicativeColors.negative5,
            IonIndicativeColors.negative4,
            IonIndicativeColors.negative3,
          ]
        : [
            IonMainColors.primary6,
            IonMainColors.primary5,
            IonMainColors.primary4,
            IonMainColors.primary3,
          ];
    iconColor =
        isDanger ? IonIndicativeColors.negative6 : IonMainColors.primary6;
    onHoverColor =
        isDanger ? IonIndicativeColors.negative1 : IonMainColors.primary1;
    onHoverBorderColor =
        isDanger ? IonIndicativeColors.negative3 : IonMainColors.primary3;
    onTapDownColor =
        isDanger ? IonIndicativeColors.negative2 : IonMainColors.primary2;
    onTapDownBorderColor =
        isDanger ? IonIndicativeColors.negative5 : IonMainColors.primary80;
    onTapDownTextColor =
        isDanger ? IonTextColor.negative7 : IonTextColor.primary7;
    onTapDownIconColor =
        isDanger ? IonIndicativeColors.negative7 : IonMainColors.primary7;
  }
}

class IonButtonGhostColors implements IonButtonColor {
  final bool isDanger;
  Color color = IonExtraColors.transparent;
  IonTextColor textColor = IonTextColor.primary6;
  Color iconColor = IonMainColors.primary6;
  Color onHover = IonMainColors.primary1;
  Color onTapDownColor = IonMainColors.primary2;
  IonTextColor onTapDownTextColor = IonTextColor.primary7;
  Color onTapDownIconColor = IonMainColors.primary7;
  List<Color> gradientColors = [
    IonMainColors.primary6,
    IonMainColors.primary5,
    IonMainColors.primary4,
    IonMainColors.primary3,
  ];

  IonButtonGhostColors(this.isDanger) {
    setColors(isDanger: isDanger);
  }

  @override
  void setColors({required bool isDanger}) {
    onHover = isDanger ? IonIndicativeColors.negative1 : IonMainColors.primary1;
    textColor = isDanger ? IonTextColor.negative6 : IonTextColor.primary6;
    gradientColors = isDanger
        ? [
            IonIndicativeColors.negative6,
            IonIndicativeColors.negative5,
            IonIndicativeColors.negative4,
            IonIndicativeColors.negative3,
          ]
        : [
            IonMainColors.primary6,
            IonMainColors.primary5,
            IonMainColors.primary4,
            IonMainColors.primary3,
          ];
    iconColor =
        isDanger ? IonIndicativeColors.negative6 : IonMainColors.primary6;
    onTapDownColor =
        isDanger ? IonIndicativeColors.negative2 : IonMainColors.primary2;
    onTapDownTextColor =
        isDanger ? IonTextColor.negative7 : IonTextColor.primary7;
    onTapDownIconColor =
        isDanger ? IonIndicativeColors.negative7 : IonMainColors.primary7;
  }
}

class IonButtonDashedColors implements IonButtonColor {
  final bool isDanger;
  Color color = IonExtraColors.transparent;
  IonTextColor textColor = IonTextColor.primary6;
  Color borderColor = IonMainColors.neutral4;
  Color iconColor = IonMainColors.primary6;
  Color onHoverColor = IonMainColors.primary1;
  Color onHoverBorderColor = IonMainColors.primary3;
  Color onTapDownColor = IonMainColors.primary2;
  Color onTapDownBorderColor = IonMainColors.primary80;
  IonTextColor onTapDownTextColor = IonTextColor.primary7;
  Color onTapDownIconColor = IonMainColors.primary7;
  List<Color> gradientColors = [
    IonMainColors.primary6,
    IonMainColors.primary5,
    IonMainColors.primary4,
    IonMainColors.primary3,
  ];

  IonButtonDashedColors(this.isDanger) {
    setColors(isDanger: isDanger);
  }

  @override
  void setColors({required bool isDanger}) {
    textColor = isDanger ? IonTextColor.negative6 : IonTextColor.primary6;
    gradientColors = isDanger
        ? [
            IonIndicativeColors.negative6,
            IonIndicativeColors.negative5,
            IonIndicativeColors.negative4,
            IonIndicativeColors.negative3,
          ]
        : [
            IonMainColors.primary6,
            IonMainColors.primary5,
            IonMainColors.primary4,
            IonMainColors.primary3,
          ];
    iconColor =
        isDanger ? IonIndicativeColors.negative6 : IonMainColors.primary6;
    onHoverColor =
        isDanger ? IonIndicativeColors.negative1 : IonMainColors.primary1;
    onHoverBorderColor =
        isDanger ? IonIndicativeColors.negative3 : IonMainColors.primary3;
    onTapDownColor =
        isDanger ? IonIndicativeColors.negative2 : IonMainColors.primary2;
    onTapDownBorderColor =
        isDanger ? IonIndicativeColors.negative5 : IonMainColors.primary80;
    onTapDownTextColor =
        isDanger ? IonTextColor.negative7 : IonTextColor.primary7;
    onTapDownIconColor =
        isDanger ? IonIndicativeColors.negative7 : IonMainColors.primary7;
  }
}
