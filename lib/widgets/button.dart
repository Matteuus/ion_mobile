import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';
import 'package:ion_mobile/widgets/circular_loading.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

abstract class IonButton extends StatelessWidget {
  String text;
  final void Function() onTap;
  void Function() onTapCancel = () {};
  void Function(bool) onHover = (bool isHover) {};
  void Function(TapUpDetails) onTapUp = (TapUpDetails details) {};
  void Function(TapDownDetails) onTapDown = (TapDownDetails details) {};
  final Widget? icon;
  String? ionIcon;
  Color? ionIconColor;
  final bool disabled;
  final bool isDanger;
  final List<Color> gradientColors;
  bool isLoading = false;
  bool dashedBorder;
  IonTextColor ionTextColor;
  Color color;
  Color borderColor;
  final double width;
  final double height;

  IonButton({
    Key? key,
    this.text = '',
    required this.onTap,
    required this.color,
    required this.width,
    required this.height,
    this.borderColor = IonExtraColors.transparent,
    this.dashedBorder = false,
    this.icon,
    this.ionIcon,
    this.ionIconColor,
    this.disabled = false,
    this.isDanger = false,
    this.gradientColors = const [
      IonMainColors.neutral1,
      IonMainColors.neutral2,
      IonMainColors.neutral3,
      IonMainColors.neutral4,
    ],
    required this.isLoading,
    required this.ionTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => InkWell(
        mouseCursor:
            disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
        onTap: disabled ? null : onTap,
        onHover: (hover) {
          if (!disabled) {
            setState(() {
              onHover(hover);
            });
          }
        },
        onTapUp: (details) {
          if (!disabled) {
            setState(() {
              onTapUp(details);
            });
          }
        },
        onTapDown: (details) {
          if (!disabled) {
            setState(() {
              onTapDown(details);
            });
          }
        },
        onTapCancel: () {
          setState(() {
            onTapCancel();
          });
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: dashedBorder
                ? RDottedLineBorder.all(
                    color: borderColor,
                    width: 1,
                  )
                : Border.all(
                    color: borderColor,
                    width: 1,
                  ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isLoading && ionIcon != null
                    ? SvgPicture.asset(
                        ionIcon!,
                        package: 'ion_mobile',
                        allowDrawingOutsideViewBox: true,
                        color: disabled ? IonMainColors.neutral5 : ionIconColor,
                      )
                    : !isLoading && icon != null
                        ? icon!
                        : const SizedBox(),
                Visibility(
                  visible: isLoading,
                  child: ZoomIn(
                    child: Row(
                      children: [
                        IonCircularLoading(
                            radius: 10.r,
                            strokeWidth: 2,
                            gradientColors: gradientColors),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                    transform: Matrix4.translationValues(
                      isLoading ? 4.w : 0,
                      0,
                      0,
                    ),
                    duration: const Duration(milliseconds: 500),
                    child: text != ''
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                isLoading ? 'Loading' : text,
                                style: IonTextStyleBody(
                                  ionFontWeight: IonFontWeight.medium,
                                  ionFontStyle: IonFontStyle.normal,
                                  ionTextColor: disabled
                                      ? IonTextColor.neutral5
                                      : ionTextColor,
                                  ionFontSize: IonBodyFontSizeHeight.large,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class IonButtonPrimary extends IonButton {
  IonButtonPrimary(
      {Key? key,
      String text = '',
      bool isDanger = false,
      required void Function() onTap,
      super.disabled,
      super.icon,
      super.ionIcon,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          isDanger: isDanger,
          onTap: onTap,
          ionIconColor: IonButtonPrimaryColors(isDanger).iconColor,
          color: disabled
              ? IonMainColors.neutral3
              : IonButtonPrimaryColors(isDanger).color,
          ionTextColor: IonButtonPrimaryColors(isDanger).textColor,
        );

  // corrigir o onTapUp que deveria mudar a cor porem nao esta alterando pois e usado o setState e ele reconstroi o componente e consequentemente chama o construtor

  @override
  void Function(bool hover) get onHover => (hover) {
        if (!disabled) {
          if (hover) {
            color = IonButtonPrimaryColors(isDanger).onHover;
          } else {
            color = IonButtonPrimaryColors(isDanger).color;
          }
        }
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonButtonPrimaryColors(isDanger).color;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonPrimaryColors(isDanger).onTapDown;
      };
}

class IonButtonSecundaryColors implements IonButtonColor {
  // unHover e onTapUp são o color;
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

class IonButtonSecundary extends IonButton {
  IonButtonSecundary(
      {Key? key,
      String text = '',
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          onTap: onTap,
          isDanger: isDanger,
          ionIconColor: IonButtonSecundaryColors(isDanger).iconColor,
          color: IonButtonSecundaryColors(isDanger).color,
          borderColor: IonButtonSecundaryColors(isDanger).borderColor,
          ionTextColor: IonButtonSecundaryColors(isDanger).textColor,
          gradientColors: IonButtonSecundaryColors(isDanger).gradientColors,
        );

  @override
  void Function(bool hover) get onHover => (hover) {
        if (hover) {
          color = IonButtonSecundaryColors(isDanger).onHoverColor;
          borderColor = IonButtonSecundaryColors(isDanger).onHoverBorderColor;
        } else {
          color = IonButtonSecundaryColors(isDanger).color;
          borderColor = IonButtonSecundaryColors(isDanger).borderColor;
        }
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonButtonSecundaryColors(isDanger).color;
        borderColor = IonButtonSecundaryColors(isDanger).borderColor;
        ionTextColor = IonButtonSecundaryColors(isDanger).textColor;
        ionIconColor = IonButtonSecundaryColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonSecundaryColors(isDanger).onTapDownColor;
        borderColor = IonButtonSecundaryColors(isDanger).onTapDownBorderColor;
        ionTextColor = IonButtonSecundaryColors(isDanger).onTapDownTextColor;
        ionIconColor = IonButtonSecundaryColors(isDanger).onTapDownIconColor;
      };
}

class IonButtonGhostColors implements IonButtonColor {
  // unHover e onTapUp são o color;
  final bool isDanger;
  Color color = IonExtraColors.transparent;
  IonTextColor textColor = IonTextColor.primary6;
  //Color borderColor = IonMainColors.neutral4;
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

class IonButtonGhost extends IonButton {
  IonButtonGhost(
      {Key? key,
      String text = '',
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          onTap: onTap,
          isDanger: isDanger,
          ionIconColor: IonButtonGhostColors(isDanger).iconColor,
          color: IonButtonGhostColors(isDanger).color,
          ionTextColor: IonButtonGhostColors(isDanger).textColor,
          gradientColors: IonButtonGhostColors(isDanger).gradientColors,
        );

  @override
  void Function(bool hover) get onHover => (hover) {
        if (hover) {
          color = IonButtonGhostColors(isDanger).onHover;
        } else {
          color = IonButtonGhostColors(isDanger).color;
        }
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonButtonGhostColors(isDanger).color;
        ionTextColor = IonButtonGhostColors(isDanger).textColor;
        ionIconColor = IonButtonGhostColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonGhostColors(isDanger).onTapDownColor;
        ionTextColor = IonButtonGhostColors(isDanger).onTapDownTextColor;
        ionIconColor = IonButtonGhostColors(isDanger).onTapDownIconColor;
      };
}

class IonButtonDashedColors implements IonButtonColor {
  // unHover e onTapUp são o color;
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

class IonButtonDashed extends IonButton {
  IonButtonDashed(
      {Key? key,
      String text = '',
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.dashedBorder = true,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          onTap: onTap,
          isDanger: isDanger,
          color: IonButtonDashedColors(isDanger).color,
          ionIconColor: IonButtonDashedColors(isDanger).iconColor,
          borderColor: IonButtonDashedColors(isDanger).borderColor,
          ionTextColor: IonButtonDashedColors(isDanger).textColor,
          gradientColors: IonButtonDashedColors(isDanger).gradientColors,
        );

  @override
  void Function(bool hover) get onHover => (hover) {
        if (hover) {
          color = IonButtonDashedColors(isDanger).onHoverColor;
          borderColor = IonButtonDashedColors(isDanger).onHoverBorderColor;
        } else {
          color = IonButtonDashedColors(isDanger).color;
          borderColor = IonButtonDashedColors(isDanger).borderColor;
        }
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonButtonDashedColors(isDanger).color;
        borderColor = IonButtonDashedColors(isDanger).borderColor;
        ionTextColor = IonButtonDashedColors(isDanger).textColor;
        ionIconColor = IonButtonDashedColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonDashedColors(isDanger).onTapDownColor;
        borderColor = IonButtonDashedColors(isDanger).onTapDownBorderColor;
        ionTextColor = IonButtonDashedColors(isDanger).onTapDownTextColor;
        ionIconColor = IonButtonDashedColors(isDanger).onTapDownIconColor;
      };
}
