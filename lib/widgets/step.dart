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
    backgroundHoverColor: IonMainColors.neutral4,
    foregroundHoverColor: IonMainColors.neutral5,
    borderHoverColor: Colors.transparent,
    backgroundPressedColor: IonMainColors.neutral4,
    foregroundPressedColor: IonMainColors.neutral5,
    borderPressedColor: Colors.transparent,
  );

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  final Color backgroundHoverColor;
  final Color foregroundHoverColor;
  final Color borderHoverColor;

  final Color backgroundPressedColor;
  final Color foregroundPressedColor;
  final Color borderPressedColor;

  const IonStepState({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.backgroundHoverColor,
    required this.foregroundHoverColor,
    required this.borderHoverColor,
    required this.backgroundPressedColor,
    required this.foregroundPressedColor,
    required this.borderPressedColor,
  });
}

abstract class IonAbstractStep {
  IonAbstractStep({
    required this.title,
    required this.subtitle,
    required this.state,
  });

  final String title;
  final String? subtitle;
  IonStepState state;
}

abstract class IonAbstractStepper extends StatefulWidget {
  const IonAbstractStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepChanged,
    required this.circleIsClicable,
    required this.circleSize,
  });

  final List<IonStep> steps;
  final int currentStep;
  final ValueChanged<int> onStepChanged;
  final bool circleIsClicable;
  final double circleSize;
}

class IonStep extends IonAbstractStep {
  IonStep({
    required super.title,
    super.state = IonStepState.upComming,
    super.subtitle,
  });
}

class IonStepper extends IonAbstractStepper {
  const IonStepper({
    super.key,
    required super.steps,
    required super.currentStep,
    required super.onStepChanged,
    super.circleIsClicable = true,
    super.circleSize = 32,
  });

  @override
  State<IonStepper> createState() => _IonStepperState();
}

class _IonStepperState extends State<IonStepper> {
  int _hoveringIndex = -1;
  bool pressed = false;

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

  IonStepState _getStepState(int index) {
    final step = widget.steps[index];

    if (index < widget.currentStep || step.state == IonStepState.completed && index == widget.currentStep) {
      return IonStepState.completed;
    } else if (index == widget.currentStep && step.state != IonStepState.disabled) {
      return IonStepState.current;
    } else if (step.state == IonStepState.disabled) {
      return IonStepState.disabled;
    } else if (step.state == IonStepState.error) {
      return IonStepState.error;
    } else {
      return IonStepState.upComming;
    }
  }

  Widget _buildCircle(int index) {
    final state = _getStepState(index);
    final String label = (index + 1).toString();

    return InkWell(
      onTap: widget.circleIsClicable == false ||
              widget.steps[index].state == IonStepState.disabled
          ? null
          : () => widget.onStepChanged(index),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return Colors.transparent;
      }),
      onHover: state == IonStepState.disabled
          ? null
          : (hover) => onHover(index, hover),
      child: Container(
        width: widget.circleSize,
        height: widget.circleSize,
        decoration: BoxDecoration(
          color: index == _hoveringIndex
              ? state.backgroundHoverColor
              : state.backgroundColor,
          border: Border.all(
            color: index == _hoveringIndex
                ? state.borderHoverColor
                : state.borderColor,
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
              : Text(label, style: _buildLabelTextStyle(state, index)),
        ),
      ),
    );
  }

  Widget _buildLine(int index) {
    final state = _getStepState(index);
    return Expanded(
      child: Container(
        width: widget.circleSize * 2,
        height: 1,
        margin: EdgeInsets.fromLTRB(8, widget.circleSize / 2, 8, 0),
        color: state == IonStepState.completed
            ? IonMainColors.primary6
            : IonMainColors.neutral4,
      ),
    );
  }

  Widget _buildTitle(int index) {
    final step = widget.steps[index];
    final state = _getStepState(index);

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

  Widget _buildSubtitle(int index) {
    final step = widget.steps[index];

    return Text(
      step.subtitle!,
      style: const IonTextStyleBody(
        ionFontStyle: IonFontStyle.normal,
        ionFontWeight: IonFontWeight.regular,
        ionFontSize: IonBodyFontSizeHeight.small,
        ionTextColor: IonTextColor.neutral6,
      ),
    );
  }

  IonTextStyleBody _buildLabelTextStyle(IonStepState state, int index) {
    switch (state) {
      case IonStepState.disabled:
        return const IonTextStyleBody(
          ionFontStyle: IonFontStyle.normal,
          ionFontWeight: IonFontWeight.medium,
          ionFontSize: IonBodyFontSizeHeight.regular,
          ionTextColor: IonTextColor.neutral5,
        );
      case IonStepState.upComming:
        return IonTextStyleBody(
          ionFontStyle: IonFontStyle.normal,
          ionFontWeight: IonFontWeight.medium,
          ionFontSize: IonBodyFontSizeHeight.regular,
          ionTextColor: _hoveringIndex == index
              ? IonTextColor.primary7
              : IonTextColor.neutral8,
        );
      default:
        return const IonTextStyleBody(
          ionFontStyle: IonFontStyle.normal,
          ionFontWeight: IonFontWeight.medium,
          ionFontSize: IonBodyFontSizeHeight.regular,
          ionTextColor: IonTextColor.neutral1,
        );
    }
  }

  Widget _buildStepper() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>{
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildCircle(i),
            _buildTitle(i),
            if (widget.steps[i].subtitle != null &&
                widget.steps[i].subtitle!.isNotEmpty) ...<Widget>{
              _buildSubtitle(i),
            }
          ],
        ),
        if (!_isLast(i)) _buildLine(i),
      }
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepper();
  }
}
