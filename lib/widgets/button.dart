import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';
import 'package:ion_mobile/widgets/circular_loading.dart';

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
  final List<Color> gradientColors;
  bool isLoading = false;
  final IonBodyColor ionBodyColor;
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
    required this.borderColor,
    this.icon,
    this.ionIcon,
    this.ionIconColor,
    this.disabled = false,
    this.gradientColors = const [
      IonMainColors.neutral1,
      IonMainColors.neutral2,
      IonMainColors.neutral3,
      IonMainColors.neutral4,
    ],
    required this.isLoading,
    required this.ionBodyColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, setState) => InkWell(
        onTap: onTap,
        onHover: (hover) {
          setState(() {
            onHover(hover);
          });
        },
        onTapUp: (details) {
          setState(() {
            onTapUp(details);
          });
        },
        onTapDown: (details) {
          setState(() {
            onTapDown(details);
          });
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
            border: Border.all(
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
                        color: ionIconColor,
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
                      isLoading ? 8.w : 0,
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
                                  ionBodyColor: ionBodyColor,
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

class IonButtonPrimary extends IonButton {
  IonButtonPrimary(
      {Key? key,
      String text = '',
      required void Function() onTap,
      super.disabled,
      super.icon,
      super.ionIcon,
      super.ionIconColor = IonMainColors.neutral1,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          onTap: onTap,
          color: IonMainColors.primary6,
          borderColor: IonMainColors.primary6,
          ionBodyColor: IonBodyColor.neutral1,
        );

  // corrigir o onTapUp que deveria mudar a cor porem nao esta alterando pois e usado o setState e ele reconstroi o componente e consequentemente chama o construtor

  @override
  void Function(bool hover) get onHover => (hover) {
        if (hover) {
          color = IonMainColors.primary5;
        } else {
          color = IonMainColors.primary6;
        }
      };

  @override
  void Function() get onTapCancel => () {
        color = IonMainColors.primary6;
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonMainColors.primary6;
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonMainColors.primary7;
      };
}

class IonButtonSecundary extends IonButton {
  IonButtonSecundary(
      {Key? key,
      String text = '',
      required void Function() onTap,
      super.icon,
      super.ionIcon,
      super.ionIconColor = IonMainColors.primary6,
      super.disabled,
      required super.height,
      required super.width,
      required super.isLoading})
      : super(
          key: key,
          text: text,
          onTap: onTap,
          color: IonMainColors.neutral1,
          borderColor: IonMainColors.neutral4,
          ionBodyColor: IonBodyColor.primary6,
          gradientColors: const [
            IonMainColors.primary6,
            IonMainColors.primary5,
            IonMainColors.primary4,
            IonMainColors.primary3,
          ],
        );

  // corrigir o onTapUp que deveria mudar a cor porem nao esta alterando pois e usado o setState e ele reconstroi o componente e consequentemente chama o construtor

  @override
  void Function(bool hover) get onHover => (hover) {
        if (hover) {
          color = IonMainColors.primary1;
        } else {
          color = IonMainColors.neutral1;
        }
      };

  @override
  void Function() get onTapCancel => () {
        color = IonMainColors.primary6;
      };

  @override
  void Function(TapUpDetails details) get onTapUp => (details) {
        color = IonMainColors.primary6;
      };

  @override
  void Function(TapDownDetails details) get onTapDown => (details) {
        color = IonMainColors.primary2;
        borderColor = IonMainColors.primary5;
      };
}
