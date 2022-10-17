import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IonInput extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const IonInput(
      {super.key,
      required this.height,
      required this.width,
      required this.hintText,
      this.maxLines = 1,
      this.keyboardType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFFAEB2BD),
            fontSize: 16.sp,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Color(0xffAEB2BD),
              )),
        ),
      ),
    );
  }
}
