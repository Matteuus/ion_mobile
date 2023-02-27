import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class IonCheckbox extends StatefulWidget {
  final String? label;
  final void Function(bool) onChange;
  final String icon;
  Color fillColor;
  Color iconColor;
  final bool isChecked;
  final bool disable;
  Color borderColor;
  final Color hoverColor;
  final bool autofocus;

  IonCheckbox({
    super.key,
    this.label,
    required this.onChange,
    this.icon = '',
    this.fillColor = IonMainColors.primary6,
    this.iconColor = IonMainColors.primary1,
    required this.isChecked,
    this.disable = false,
    this.borderColor = IonMainColors.neutral5,
    this.hoverColor = IonMainColors.primary2,
    this.autofocus = false,
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
    onFocus();
  }

  void onFocus() {
    if (widget.autofocus) {
      setState(() {
        focusBorderColor = Border.all(color: IonMainColors.primary5, width: 2);
        widget.borderColor = IonMainColors.primary3;
        widget.fillColor = IonMainColors.primary5;
      });
    } else {
      setState(() {
        focusBorderColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.disable
        ? Stack(children: [
            Center(
                child: Container(
              height: 16.h,
              width: 4.w,
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
                      size: 13.h,
                      color: IonMainColors.neutral4,
                    )
                  : null,
            ))
          ])
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
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 24.h,
              width: 6.w,
              decoration: BoxDecoration(
                border: isHovering ? null : focusBorderColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isHovering ? widget.hoverColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 16.h,
                        width: 4.w,
                        decoration: BoxDecoration(
                          color: widget.isChecked
                              ? widget.fillColor
                              : IonMainColors.neutral1,
                          border: Border.all(
                            color: widget.isChecked
                                ? Colors.transparent
                                : widget.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: widget.isChecked || isHovering
                            ? Icon(
                                Icons.check,
                                size: 13.h,
                                color: widget.isChecked
                                    ? IonMainColors.primary1
                                    : widget.iconColor,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
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
    super.borderColor,
    super.disable,
    super.fillColor,
    super.hoverColor,
    super.icon,
    super.iconColor,
    super.label,
  });
}
