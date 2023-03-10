import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/widgets/button/button_colors.dart';
import 'package:ion_mobile/widgets/circular_loading.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

enum IonIconButtonType {
  square(0),
  rounded(1);

  final int type;

  const IonIconButtonType(this.type);
}

abstract class IonIconButton extends StatelessWidget {
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
  Color color;
  Color borderColor;
  final double width;
  final double height;
  final IonIconButtonType buttonType;

  IonIconButton({
    Key? key,
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
    this.buttonType = IonIconButtonType.square,
    this.gradientColors = const [
      IonMainColors.neutral1,
      IonMainColors.neutral2,
      IonMainColors.neutral3,
      IonMainColors.neutral4,
    ],
    required this.isLoading,
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
            borderRadius: buttonType == IonIconButtonType.square
                ? BorderRadius.circular(10)
                : BorderRadius.circular(90),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IonIconButtonPrimary extends IonIconButton {
  IonIconButtonPrimary(
      {Key? key,
      bool isDanger = false,
      required void Function() onTap,
      super.disabled,
      super.icon,
      super.ionIcon,
      super.buttonType,
      required super.height,
      required super.width,
      required super.isLoading})
      : assert(icon != null || ionIcon != null,
            "Um ícone é necessário para instanciar essa classe"),
        super(
          key: key,
          isDanger: isDanger,
          onTap: onTap,
          ionIconColor: IonButtonPrimaryColors(isDanger).iconColor,
          color: disabled
              ? IonMainColors.neutral3
              : IonButtonPrimaryColors(isDanger).color,
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

class IonIconButtonSecundary extends IonIconButton {
  IonIconButtonSecundary(
      {Key? key,
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.buttonType,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          onTap: onTap,
          isDanger: isDanger,
          ionIconColor: IonButtonSecundaryColors(isDanger).iconColor,
          color: IonButtonSecundaryColors(isDanger).color,
          borderColor: IonButtonSecundaryColors(isDanger).borderColor,
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
        ionIconColor = IonButtonSecundaryColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonSecundaryColors(isDanger).onTapDownColor;
        borderColor = IonButtonSecundaryColors(isDanger).onTapDownBorderColor;
        ionIconColor = IonButtonSecundaryColors(isDanger).onTapDownIconColor;
      };
}

class IonIconButtonGhost extends IonIconButton {
  IonIconButtonGhost(
      {Key? key,
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.buttonType,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          onTap: onTap,
          isDanger: isDanger,
          ionIconColor: IonButtonGhostColors(isDanger).iconColor,
          color: IonButtonGhostColors(isDanger).color,
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
        ionIconColor = IonButtonGhostColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonGhostColors(isDanger).onTapDownColor;
        ionIconColor = IonButtonGhostColors(isDanger).onTapDownIconColor;
      };
}

class IonIconButtonDashed extends IonIconButton {
  IonIconButtonDashed(
      {Key? key,
      bool isDanger = false,
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.buttonType,
      super.dashedBorder = true,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          onTap: onTap,
          isDanger: isDanger,
          color: IonButtonDashedColors(isDanger).color,
          ionIconColor: IonButtonDashedColors(isDanger).iconColor,
          borderColor: IonButtonDashedColors(isDanger).borderColor,
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
        ionIconColor = IonButtonDashedColors(isDanger).iconColor;
        onHover(true);
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonButtonDashedColors(isDanger).onTapDownColor;
        borderColor = IonButtonDashedColors(isDanger).onTapDownBorderColor;
        ionIconColor = IonButtonDashedColors(isDanger).onTapDownIconColor;
      };
}
