import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/typography.dart';

abstract class IonCheckbox extends StatefulWidget {
  final String label;
  final void Function(bool) onChange;
  final String icon;
  Color fillColor;
  Color iconColor;
  final bool isChecked;
  final bool disable;
  Color borderColor;
  final Color hoverColor;
  final bool autofocus;
  final List<IonCheckboxSimple> items;
  final double height;
  final double width;

  IonCheckbox({
    super.key,
    this.label = '',
    required this.onChange,
    this.icon = '',
    this.fillColor = IonMainColors.primary6,
    this.iconColor = IonMainColors.primary1,
    required this.isChecked,
    this.disable = false,
    this.borderColor = IonMainColors.neutral5,
    this.hoverColor = IonMainColors.primary2,
    this.autofocus = false,
    this.items = const [],
    this.height = 24,
    this.width = 24,
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
    if (widget.items.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var item in widget.items)
            IonCheckboxSimple(
              borderColor: item.borderColor,
              fillColor: item.fillColor,
              hoverColor: item.hoverColor,
              iconColor: item.iconColor,
              isChecked: item.isChecked,
              label: item.label,
              onChange: item.onChange,
              autofocus: item.autofocus,
              disable: item.disable,
              icon: item.icon,
              height: widget.height,
              width: widget.width,
            ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            widget.onChange(!widget.isChecked);
          });
        },
        autofocus: false,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHover: widget.disable ? null : onHover,
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: widget.label != ''
            ? IonCheckboxItemLabel(
                isHovering: isHovering,
                focusBorderColor: focusBorderColor,
                hoverColor: widget.hoverColor,
                isChecked: widget.isChecked,
                fillColor: widget.fillColor,
                borderColor: widget.borderColor,
                iconColor: widget.iconColor,
                label: widget.label,
                height: widget.height,
                width: widget.width,
                disable: widget.disable,
              )
            : IonCheckboxItemNoLabel(
                isHovering: isHovering,
                focusBorderColor: focusBorderColor,
                borderColor: widget.borderColor,
                fillColor: widget.fillColor,
                hoverColor: widget.hoverColor,
                iconColor: widget.iconColor,
                isChecked: widget.isChecked,
                height: widget.height,
                width: widget.width,
                disable: widget.disable,
              ),
      );
    }
  }
}

class IonCheckboxSimple extends IonCheckbox {
  IonCheckboxSimple({
    super.key,
    required super.onChange,
    required super.isChecked,
    super.autofocus,
    super.borderColor,
    super.disable,
    super.fillColor,
    super.hoverColor,
    super.icon,
    super.iconColor,
    super.label,
    super.height,
    super.width,
  });
}

class IonCheckboxList extends IonCheckbox {
  IonCheckboxList({
    super.key,
    required super.onChange,
    required super.isChecked,
    required super.items,
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
    required this.height,
    required this.width,
    required this.disable,
  });

  final bool isHovering;
  final Border focusBorderColor;
  final bool isChecked;
  final Color hoverColor;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final double height;
  final double width;
  final bool disable;

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
      height: height,
      width: width,
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
            height: height * 0.66,
            width: width * 0.66,
            decoration: BoxDecoration(
              color: backgroundCheckboxColor,
              border: Border.all(
                color: borderColorValue,
                width: borderSize,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: isChecked || isHovering
                ? Icon(
                    Icons.check,
                    size: height * 0.5,
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
    required this.height,
    required this.width,
    this.disable = false,
  });

  final bool isHovering;
  final Border focusBorderColor;
  final Color hoverColor;
  final bool isChecked;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final String label;
  final double height;
  final double width;
  final bool disable;

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
          height: height,
          width: width,
          disable: disable,
        ),
        const SizedBox(width: 12),
        Text(label, style: disable ? styleDisable : style),
      ],
    );
  }
}
