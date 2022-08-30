import 'package:flutter/material.dart';

class IonCircularLoading extends StatefulWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;
  const IonCircularLoading(
      {Key? key,
      required this.radius,
      required this.gradientColors,
      required this.strokeWidth})
      : super(key: key);

  @override
  State<IonCircularLoading> createState() => _IonCircularLoadingState();
}

class _IonCircularLoadingState extends State<IonCircularLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController!.addListener(() => setState(() {}));
    _animationController!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController!.drive(
        CurveTween(
            curve: const Interval(0.0, 1.0, curve: Curves.easeInOutSine)),
      ),
      child: GradientCircularProgressIndicator(
        radius: widget.radius,
        gradientColors: widget.gradientColors,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  const GradientCircularProgressIndicator({
    Key? key,
    required this.radius,
    required this.gradientColors,
    this.strokeWidth = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
        radius: radius,
        gradientColors: gradientColors,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.radius,
    required this.gradientColors,
    required this.strokeWidth,
  });
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double offset = strokeWidth / 2;
    Rect rect = Offset(offset, offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    paint.shader = LinearGradient(
      colors: gradientColors,
      tileMode: TileMode.mirror,
    ).createShader(rect);

    canvas.drawArc(rect, 0.0, 0.9, false, paint);
    canvas.drawArc(rect, 1, 0.9, false, paint);
    canvas.drawArc(rect, 2, 0.9, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
