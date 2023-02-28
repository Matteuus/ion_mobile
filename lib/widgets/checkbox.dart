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
      return widget.disable
          ? Center(
              child: Container(
              height: widget.height * 0.66,
              width: widget.width * 0.66,
              decoration: BoxDecoration(
                color: widget.isChecked
                    ? IonMainColors.neutral2
                    : IonMainColors.neutral3,
                border: Border.all(
                  color: widget.isChecked
                      ? Colors.transparent
                      : IonMainColors.neutral4,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: widget.isChecked
                  ? Icon(
                      Icons.check,
                      size: widget.height * 0.8,
                      color: IonMainColors.neutral4,
                    )
                  : null,
            ))
          : InkWell(
              onTap: () {
                setState(() {
                  widget.onChange(!widget.isChecked);
                });
              },
              autofocus: false,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: onHover,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: isHovering ? null : focusBorderColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isHovering ? hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Container(
            height: height * 0.66,
            width: width * 0.66,
            decoration: BoxDecoration(
              color: isChecked ? fillColor : IonMainColors.neutral1,
              border: Border.all(
                color: isChecked ? Colors.transparent : borderColor,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: isChecked || isHovering
                ? Icon(
                    Icons.check,
                    size: height * 0.5,
                    color: isChecked ? IonMainColors.primary1 : iconColor,
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

  @override
  Widget build(BuildContext context) {
    const IonTextStyleBody style = IonTextStyleBody(
      ionFontWeight: IonFontWeight.regular,
      ionFontStyle: IonFontStyle.normal,
      ionBodyColor: IonBodyColor.neutral7,
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
        ),
        const SizedBox(width: 12),
        Text(label, style: style),
      ],
    );
  }
}
