import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';
import 'package:ion_mobile/widgets/circular_loading.dart';

abstract class IonButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  void Function() onTapCancel = () {};
  void Function(bool) onHover = (bool isHover) {};
  void Function(TapUpDetails) onTapUp = (TapUpDetails details) {};
  void Function(TapDownDetails) onTapDown = (TapDownDetails details) {};
  final bool disabled;
  bool isLoading = false;
  final IonBodyColor ionBodyColor;
  Color color;
  final Color borderColor;
  final double width;
  final double height;
  IonButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.width,
    required this.height,
    required this.borderColor,
    this.disabled = false,
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
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isLoading,
                  child: FadeInRight(
                    child: Row(
                      children: [
                        IonCircularLoading(
                          radius: 10.r,
                          strokeWidth: 2,
                          gradientColors: const [
                            IonMainColors.neutral1,
                            IonMainColors.neutral2,
                            IonMainColors.neutral3,
                            IonMainColors.neutral4,
                          ],
                        ),
                        //SizedBox(width: 8.w),
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
                  child: Text(
                    text,
                    style: IonTextStyleBody(
                      ionFontWeight: IonFontWeight.regular,
                      ionFontStyle: IonFontStyle.normal,
                      ionBodyColor: ionBodyColor,
                      ionFontSize: IonBodyFontSizeHeight.large,
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

class IonButtonPrimary extends IonButton {
  IonButtonPrimary(
      {Key? key,
      required String text,
      required void Function() onTap,
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

// class IonButtonSecondary extends IonButton {
//   const IonButtonSecondary({
//     Key? key,
//     required String text,
//     required void Function() onTap,
//     required IonTextStyle textStyle,
//     required super.height,
//     required super.width,
//   }) : super(
//           key: key,
//           text: text,
//           onTap: onTap,
//           color: Colors.transparent,
//           borderColor: IonMainColors.primary6,
//           textStyle: textStyle,
//         );
// }
