import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography.dart';

enum IonCheckboxType {
  check("/home/brisanet/Documentos/ion_mobile/assets/icons/check.svg"),
  indeterminate("/home/brisanet/Documentos/ion_mobile/assets/icons/sub.svg");

  final String icon;

  const IonCheckboxType(this.icon);
}

abstract class IonCheckbox extends StatefulWidget {
  final String label;
  void Function(bool)? onChange;
  Color fillColor;
  Color iconColor;
  bool? isChecked;
  final bool disable;
  Color borderColor;
  final Color hoverColor;
  final bool autofocus;
  final double size;
  final IonCheckboxType type;

  IonCheckbox({
    super.key,
    this.label = '',
    this.onChange,
    this.fillColor = IonMainColors.primary6,
    this.iconColor = IonMainColors.primary1,
    this.isChecked,
    this.disable = false,
    this.borderColor = IonMainColors.neutral5,
    this.hoverColor = IonMainColors.primary2,
    this.autofocus = false,
    this.size = 24,
    this.type = IonCheckboxType.check,
  });

  @override
  State<IonCheckbox> createState() => _IonCheckboxState();
}

class _IonCheckboxState extends State<IonCheckbox> {
  bool isHovering = false;
  Border focusBorderColor = Border.all(color: Colors.transparent);

  @override
  void initState() {
    super.initState();
    onFocus();
  }

  void onHover(bool hover) {
    setState(() {
      isHovering = hover;
      if (hover) {
        widget.fillColor = IonMainColors.primary5;
        widget.borderColor = IonMainColors.primary3;
        widget.iconColor = IonMainColors.primary2;
      } else {
        widget.fillColor = IonMainColors.primary6;
        widget.borderColor = IonMainColors.neutral5;
        widget.iconColor = IonMainColors.primary1;
      }
    });
    if (widget.autofocus) onFocus();
  }

  void onFocus() {
    if (widget.autofocus) {
      focusBorderColor = Border.all(color: IonMainColors.primary5, width: 2);
      setState(() {
        widget.borderColor = IonMainColors.primary3;
        widget.fillColor = IonMainColors.primary5;
      });
    } else {
      focusBorderColor = Border.all(color: Colors.transparent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.disable) return;
        if (widget.isChecked == null) return;
        if (widget.onChange == null) return;
        setState(() {
          widget.onChange!(!widget.isChecked!);
        });
      },
      autofocus: false,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHover: widget.disable ? null : onHover,
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return Colors.transparent;
        },
      ),
      child: widget.label != ''
          ? IonCheckboxItemLabel(
              isHovering: isHovering,
              focusBorderColor: focusBorderColor,
              hoverColor: widget.hoverColor,
              isChecked: widget.isChecked!,
              fillColor: widget.fillColor,
              borderColor: widget.borderColor,
              iconColor: widget.iconColor,
              label: widget.label,
              disable: widget.disable,
              icon: widget.type.icon,
              size: widget.size,
            )
          : IonCheckboxItemNoLabel(
              isHovering: isHovering,
              focusBorderColor: focusBorderColor,
              borderColor: widget.borderColor,
              fillColor: widget.fillColor,
              hoverColor: widget.hoverColor,
              iconColor: widget.iconColor,
              isChecked: widget.isChecked!,
              disable: widget.disable,
              icon: widget.type.icon,
              size: widget.size,
            ),
    );
  }
}

class IonCheckboxSimple extends IonCheckbox {
  IonCheckboxSimple({
    super.key,
    required super.onChange,
    required super.isChecked,
    super.autofocus,
    super.disable,
    super.label,
    super.type,
    super.size,
  });
}

class IonCheckboxItemNoLabel extends StatelessWidget {
  const IonCheckboxItemNoLabel({
    super.key,
    required this.isHovering,
    required this.focusBorderColor,
    required this.isChecked,
    required this.hoverColor,
    required this.fillColor,
    required this.borderColor,
    required this.iconColor,
    required this.disable,
    required this.icon,
    required this.size,
  });

  final bool isHovering;
  final Border focusBorderColor;
  final bool isChecked;
  final Color hoverColor;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final bool disable;
  final String icon;
  final double size;

  static const double borderSize = 1.0;
  static const double borderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = disable
        ? Colors.transparent
        : isHovering
            ? hoverColor
            : Colors.transparent;

    final Color foregroundColor = disable
        ? IonMainColors.neutral4
        : isChecked
            ? IonMainColors.primary1
            : iconColor;

    final Color borderColorValue = disable
        ? IonMainColors.neutral4
        : isChecked
            ? Colors.transparent
            : borderColor;

    final Color backgroundCheckboxColor = disable && isChecked
        ? IonMainColors.neutral2
        : disable
            ? IonMainColors.neutral3
            : isChecked
                ? fillColor
                : IonMainColors.neutral1;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: isHovering || disable ? null : focusBorderColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Center(
          child: Container(
            height: size * 0.66,
            width: size * 0.66,
            decoration: BoxDecoration(
              color: backgroundCheckboxColor,
              border: Border.all(
                color: borderColorValue,
                width: borderSize,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: isChecked || isHovering
                ? SvgPicture.asset(
                    icon,
                    height: size,
                    color: foregroundColor,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class IonCheckboxItemLabel extends StatelessWidget {
  const IonCheckboxItemLabel({
    super.key,
    required this.isHovering,
    required this.focusBorderColor,
    required this.hoverColor,
    required this.isChecked,
    required this.fillColor,
    required this.borderColor,
    required this.iconColor,
    required this.label,
    this.disable = false,
    required this.icon,
    required this.size,
  });

  final bool isHovering;
  final Border focusBorderColor;
  final Color hoverColor;
  final bool isChecked;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final String label;
  final bool disable;
  final String icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    const IonTextStyleBody style = IonTextStyleBody(
      ionFontWeight: IonFontWeight.regular,
      ionFontStyle: IonFontStyle.normal,
      ionBodyColor: IonBodyColor.neutral7,
      ionFontSize: IonBodyFontSizeHeight.regular,
    );

    const IonTextStyleBody styleDisable = IonTextStyleBody(
      ionFontWeight: IonFontWeight.regular,
      ionFontStyle: IonFontStyle.normal,
      ionBodyColor: IonBodyColor.neutral5,
      ionFontSize: IonBodyFontSizeHeight.regular,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IonCheckboxItemNoLabel(
          isHovering: isHovering,
          focusBorderColor: focusBorderColor,
          isChecked: isChecked,
          hoverColor: hoverColor,
          fillColor: fillColor,
          borderColor: borderColor,
          iconColor: iconColor,
          disable: disable,
          icon: icon,
          size: size,
        ),
        const SizedBox(width: 12),
        Text(label, style: disable ? styleDisable : style),
      ],
    );
  }
}
