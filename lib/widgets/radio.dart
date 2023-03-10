import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography/body.dart';
import 'package:ion_mobile/design/typography/text_style.dart';

abstract class IonRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final String label;
  final Color color;
  final bool disabled;
  final ValueChanged<T?> onChanged;
  final Color borderColor;
  final IonTextStyle labelStyle;
  final List<IonRadioButton> items;
  final Color hoverColor;
  final double size;
  final bool autoFocus;
  final Color hoverBorderColor;

  const IonRadio({
    required this.value,
    super.key,
    this.groupValue,
    this.label = '',
    this.color = IonMainColors.primary6,
    this.disabled = false,
    required this.onChanged,
    this.borderColor = IonMainColors.neutral5,
    this.labelStyle = const IonTextStyleBody(
      ionFontStyle: IonFontStyle.normal,
      ionFontWeight: IonFontWeight.regular,
      ionBodyColor: IonBodyColor.neutral7,
    ),
    this.items = const [],
    this.hoverColor = IonMainColors.primary1,
    this.size = 24,
    this.autoFocus = false,
    this.hoverBorderColor = IonMainColors.primary3,
  });

  @override
  State<IonRadio<T>> createState() => _IonRadioState<T>();
}

class _IonRadioState<T> extends State<IonRadio<T>> {
  bool hasFocus = false;
  bool isHovering = false;

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void onHover(bool hover) {
    setState(() {
      isHovering = hover;
    });
  }

  Color getFillColor() {
    if (widget.disabled) {
      return Colors.transparent;
    }

    if (widget.groupValue == widget.value && isHovering) {
      return IonMainColors.primary1;
    }

    if (widget.groupValue == widget.value) {
      return Colors.transparent;
    }

    if (isHovering) {
      return widget.hoverColor;
    }

    return IonMainColors.neutral1;
  }

  Color getCenterCircleColor() {
    if (widget.disabled && widget.groupValue == widget.value) {
      return IonMainColors.neutral2;
    }

    if (widget.disabled) {
      return IonMainColors.neutral2;
    }

    if (widget.groupValue == widget.value && isHovering) {
      return IonMainColors.primary5;
    }

    if (widget.groupValue == widget.value) {
      return widget.color;
    }

    if (isHovering) {
      return widget.hoverColor;
    }

    return IonMainColors.neutral1;
  }

  Color getCenterCircleBorderColor() {
    if (widget.disabled) {
      return (widget.groupValue == widget.value)
          ? Colors.transparent
          : IonMainColors.neutral4;
    }

    if (widget.groupValue == widget.value) {
      return Colors.transparent;
    }

    if (hasFocus) {
      return IonMainColors.primary3;
    }

    if (isHovering) {
      return widget.hoverBorderColor;
    }

    return widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: widget.disabled
              ? null
              : () {
                  if (widget.groupValue != widget.value) {
                    setState(() => widget.onChanged(widget.value));
                  }
                },
          onHover: widget.disabled ? null : onHover,
          focusNode: focusNode,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.transparent;
            },
          ),
          autofocus: widget.autoFocus,
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: getFillColor(),
              border: Border.all(
                color: isHovering
                    ? Colors.transparent
                    : hasFocus
                        ? IonMainColors.primary5
                        : Colors.transparent,
                width: hasFocus ? 2 : 1,
              ),
            ),
            child: Center(
              child: Container(
                height: widget.size * 0.66,
                width: widget.size * 0.66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: getCenterCircleColor(),
                  border: Border.all(
                    color: getCenterCircleBorderColor(),
                    width: 1,
                  ),
                ),
                child: widget.groupValue == widget.value
                    ? Center(
                        child: Container(
                          height: widget.size * 0.33,
                          width: widget.size * 0.33,
                          decoration: BoxDecoration(
                            color: widget.disabled
                                ? IonMainColors.neutral4
                                : widget.groupValue == widget.value
                                    ? IonMainColors.primary1
                                    : IonMainColors.neutral1,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      )
                    : isHovering
                        ? Center(
                            child: Container(
                              height: widget.size * 0.1667,
                              width: widget.size * 0.1667,
                              decoration: BoxDecoration(
                                color: IonMainColors.primary2,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          )
                        : Container(),
              ),
            ),
          ),
        ),
        if (widget.label != '') const SizedBox(width: 12),
        Text(
          widget.label,
          style: widget.disabled
              ? const IonTextStyleBody(
                  ionFontWeight: IonFontWeight.regular,
                  ionFontStyle: IonFontStyle.normal,
                  ionBodyColor: IonBodyColor.neutral5,
                )
              : widget.labelStyle,
        )
      ],
    );
  }
}

class IonRadioButton<T> extends IonRadio {
  const IonRadioButton({
    super.key,
    required super.value,
    super.label,
    required super.onChanged,
    required super.groupValue,
    super.disabled,
    super.size,
    super.autoFocus,
  });
}
