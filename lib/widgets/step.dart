import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/design/typography/body.dart';
import 'package:ion_mobile/design/typography/text_style.dart';

enum IonStepState {
  upComming(
    backgroundColor: IonMainColors.neutral1,
    foregroundColor: IonMainColors.neutral8,
    borderColor: IonMainColors.neutral4,
    backgroundHoverColor: IonMainColors.neutral1,
    foregroundHoverColor: IonMainColors.primary7,
    borderHoverColor: IonMainColors.primary4,
    backgroundPressedColor: IonMainColors.primary1,
    foregroundPressedColor: IonMainColors.primary7,
    borderPressedColor: IonMainColors.primary6,
  ),
  completed(
    backgroundColor: IonMainColors.primary1,
    foregroundColor: IonMainColors.primary6,
    borderColor: IonMainColors.primary6,
    backgroundHoverColor: IonMainColors.primary2,
    foregroundHoverColor: IonMainColors.primary6,
    borderHoverColor: IonMainColors.primary6,
    backgroundPressedColor: IonMainColors.primary2,
    foregroundPressedColor: IonMainColors.primary6,
    borderPressedColor: IonMainColors.primary7,
  ),
  current(
    backgroundColor: IonMainColors.primary6,
    foregroundColor: IonMainColors.neutral1,
    borderColor: Colors.transparent,
    backgroundHoverColor: IonMainColors.primary5,
    foregroundHoverColor: IonMainColors.neutral1,
    borderHoverColor: Colors.transparent,
    backgroundPressedColor: IonMainColors.primary7,
    foregroundPressedColor: IonMainColors.neutral1,
    borderPressedColor: Colors.transparent,
  ),
  error(
    backgroundColor: IonIndicativeColors.negative6,
    foregroundColor: IonMainColors.neutral1,
    borderColor: Colors.transparent,
    backgroundHoverColor: IonIndicativeColors.negative5,
    foregroundHoverColor: IonMainColors.neutral1,
    borderHoverColor: Colors.transparent,
    backgroundPressedColor: IonIndicativeColors.negative7,
    foregroundPressedColor: IonMainColors.neutral1,
    borderPressedColor: Colors.transparent,
  ),
  disabled(
    backgroundColor: IonMainColors.neutral4,
    foregroundColor: IonMainColors.neutral5,
    borderColor: Colors.transparent,
  );

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  final Color? backgroundHoverColor;
  final Color? foregroundHoverColor;
  final Color? borderHoverColor;

  final Color? backgroundPressedColor;
  final Color? foregroundPressedColor;
  final Color? borderPressedColor;

  const IonStepState({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.backgroundHoverColor,
    this.foregroundHoverColor,
    this.borderHoverColor,
    this.backgroundPressedColor,
    this.foregroundPressedColor,
    this.borderPressedColor,
  });
}

class IonStep {
  IonStep({
    required this.title,
    this.subtitle,
    this.state = IonStepState.upComming,
  });

  final String title;
  final String? subtitle;
  IonStepState state;
}

class IonStepper extends StatefulWidget {
  IonStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    required this.onStepChanged,
  });

  List<IonStep> steps;
  final int currentStep;
  final ValueChanged<int> onStepChanged;

  @override
  State<IonStepper> createState() => _IonStepperState();
}

class _IonStepperState extends State<IonStepper> {
  int _hoveringIndex = -1;

  void _onChangeStep(int index) {
    if (index < 0 || index > widget.steps.length) return;
    if (widget.steps[index].state == IonStepState.disabled) return;

    for (int i = 0; i < widget.steps.length; i++) {
      final step = widget.steps[i];

      if (i < index - 1) {
        step.state = IonStepState.completed;
      } else if (i == index - 1) {
        step.state = IonStepState.current;
      } else if (step.state == IonStepState.disabled) {
        step.state = IonStepState.disabled;
      } else if (step.state == IonStepState.error) {
        step.state = IonStepState.error;
      } else {
        step.state = IonStepState.upComming;
      }
    }

    widget.onStepChanged(index);
  }

  void onHover(int index, bool hover) {
    setState(() {
      _hoveringIndex = hover ? index : -1;
    });
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  Widget _buildCircle(int index) {
    final step = widget.steps[index];
    IonStepState state = step.state;
    final String label = (index + 1).toString();

    if (index < widget.currentStep) {
      state = IonStepState.completed;
    } else if (index == widget.currentStep) {
      state = IonStepState.current;
    } else if (step.state == IonStepState.disabled) {
      state = IonStepState.disabled;
    } else if (step.state == IonStepState.error) {
      state = IonStepState.error;
    } else {
      state = IonStepState.upComming;
    }

    return InkWell(
      onTap: () {
        _onChangeStep(index);
      },
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return Colors.transparent;
      }),
      onHover: state == IonStepState.disabled
          ? null
          : (hover) => onHover(index, hover),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: index == _hoveringIndex
              ? state.backgroundHoverColor
              : state.backgroundColor,
          border: Border.all(
            color: state.borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Center(
          child: state == IonStepState.completed
              ? SvgPicture.asset(
                  IonIcons.check,
                  package: 'ion_mobile',
                  allowDrawingOutsideViewBox: true,
                  color: index == _hoveringIndex
                      ? state.foregroundHoverColor
                      : state.foregroundColor,
                )
              : Text(label, style: _buildLabelTextStyle(state)),
        ),
      ),
    );
  }

  Widget _buildLine(int index) {
    final step = widget.steps[index];
    IonStepState state = step.state;

    if (index < widget.currentStep) {
      state = IonStepState.completed;
    } else if (index == widget.currentStep) {
      state = IonStepState.current;
    } else if (step.state == IonStepState.disabled) {
      state = IonStepState.disabled;
    } else {
      state = IonStepState.upComming;
    }

    return Container(
      width: 32,
      height: 1,
      margin: const EdgeInsets.only(top: 16),
      color: state == IonStepState.completed
          ? IonMainColors.primary6
          : IonMainColors.neutral4,
    );
  }

  Widget _buildTitle(int index) {
    final step = widget.steps[index];
    IonStepState state = step.state;

    if (index < widget.currentStep) {
      state = IonStepState.completed;
    } else if (index == widget.currentStep) {
      state = IonStepState.current;
    } else if (step.state == IonStepState.disabled) {
      state = IonStepState.disabled;
    } else {
      state = IonStepState.upComming;
    }
    return Text(
      step.title,
      style: IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.regular,
        ionFontSize: IonBodyFontSizeHeight.regular,
        ionTextColor: state == IonStepState.current
            ? IonTextColor.neutral7
            : IonTextColor.neutral6,
      ),
    );
  }

  IonTextStyleBody _buildLabelTextStyle(IonStepState state) {
    if (state == IonStepState.disabled) {
      return const IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.medium,
        ionFontSize: IonBodyFontSizeHeight.regular,
        ionTextColor: IonTextColor.neutral5,
      );
    } else if (state == IonStepState.upComming) {
      return const IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.medium,
        ionFontSize: IonBodyFontSizeHeight.regular,
      );
    } else {
      return const IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.medium,
        ionFontSize: IonBodyFontSizeHeight.regular,
        ionTextColor: IonTextColor.neutral1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.steps.length,
        (index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_isFirst(index)) _buildLine(index),
              if (!_isFirst(index)) const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCircle(index),
                  _buildTitle(index),
                  if (widget.steps[index].subtitle != null &&
                      widget.steps[index].subtitle != "")
                    Text(
                      widget.steps[index].subtitle!,
                      style: const IonTextStyleBody(
                        ionFontStyle: IonFontStyle.normal,
                        ionFontWeight: IonFontWeight.regular,
                        ionFontSize: IonBodyFontSizeHeight.small,
                        ionTextColor: IonTextColor.neutral6,
                      ),
                    )
                ],
              ),
              if (!_isLast(index)) const SizedBox(width: 8),
              if (!_isLast(index)) _buildLine(index),
            ],
          );
        },
      ),
    );
  }
}
