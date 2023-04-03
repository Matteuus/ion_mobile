import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography/body.dart';
import 'package:ion_mobile/design/typography/text_style.dart';

enum IonStepState {
  upComming(
    backgroundColor: IonMainColors.neutral1,
    foregroundColor: IonMainColors.neutral8,
    borderColor: IonMainColors.neutral4,
  ),
  completed(
    backgroundColor: IonMainColors.primary1,
    foregroundColor: IonMainColors.primary6,
    borderColor: IonMainColors.primary6,
  ),
  current(
    backgroundColor: IonMainColors.primary6,
    foregroundColor: IonMainColors.neutral1,
    borderColor: Colors.transparent,
  ),
  error(
    backgroundColor: IonIndicativeColors.negative6,
    foregroundColor: IonMainColors.neutral1,
    borderColor: Colors.transparent,
  );

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  const IonStepState({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });
}

class IonStep {
  IonStep({
    required this.title,
    this.subtitle,
    this.state = IonStepState.upComming,
  });

  final String title;
  final Widget? subtitle;
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
  void _onChangeStep(int index) {
    if (index < 0 || index > widget.steps.length) return;

    setState(() {
      for (int i = 0; i < widget.steps.length; i++) {
        final step = widget.steps[i];

        if (i < index - 1) {
          step.state = IonStepState.completed;
        } else if (i == index - 1) {
          step.state = IonStepState.current;
        } else {
          step.state = IonStepState.upComming;
        }
      }
    });

    widget.onStepChanged(index);
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
    } else {
      state = IonStepState.upComming;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: state.backgroundColor,
        border: Border.all(
          color: state.borderColor,
          width: state == IonStepState.current ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: state == IonStepState.completed
            ? const Icon(
                Icons.check,
                color: IonMainColors.primary6,
              )
            : Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: state.foregroundColor,
                ),
              ),
      ),
    );
  }

  Widget _buildLine(int index) {
    final step = widget.steps[index];
    var color = step.state == IonStepState.completed
        ? IonMainColors.primary6
        : IonMainColors.neutral4;
    return Container(width: 32, height: 1, color: color);
  }

  Widget _buildTitle(int index) {
    final step = widget.steps[index];
    return Text(
      step.title,
      style: IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.regular,
        ionFontSize: IonBodyFontSizeHeight.regular,
        ionTextColor: step.state == IonStepState.completed
            ? IonTextColor.neutral7
            : IonTextColor.neutral6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        widget.steps.length,
        (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isFirst(index)) _buildLine(index),
                  InkWell(
                    onTap: () {
                      _onChangeStep(index);
                    },
                    child: _buildCircle(index),
                  ),
                  if (!_isLast(index)) _buildLine(index)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(index),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
