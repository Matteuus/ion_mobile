import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/design/typography/body.dart';
import 'package:ion_mobile/design/typography/footnote.dart';
import 'package:ion_mobile/design/typography/heading.dart';
import 'package:ion_mobile/design/typography/text_style.dart';

abstract class IonChip extends Chip {
  // final Widget? avatar;
  // final Widget? deleteIcon;
  // final Color? deleteIonColor;
  final Color? backgroundColor;
  final BorderSide? side;
  const IonChip(
      {super.key,
      required super.label,
      this.backgroundColor,
      this.side,
      super.avatar,
      super.onDeleted,
      super.deleteIcon})
      : super(
          backgroundColor: backgroundColor,
          side: side,
        );
}

class IonChipSelected extends IonChip {
  final String? text;
  final String? icon;
  IonChipSelected({
    super.key,
    required this.text,
    super.onDeleted,
    this.icon,
  }) : super(
            backgroundColor: IonMainColors.primary1,
            side: const BorderSide(color: IonMainColors.primary5, width: 1.5),
            label: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(text!,
                  style: const IonTextStyleBody(
                      ionFontWeight: IonFontWeight.medium,
                      ionFontStyle: IonFontStyle.normal,
                      ionBodyColor: IonBodyColor.primary6,
                      ionFontSize: IonBodyFontSizeHeight.regular)),
            ),
            avatar: icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SvgPicture.asset(
                      icon,
                      color: IonMainColors.primary6,
                      package: 'ion_mobile',
                    ),
                  )
                : null,
            deleteIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                IonIcons.close,
                color: IonMainColors.primary6,
                package: 'ion_mobile',
              ),
            ));
}



// Chip(
//                             label: const Text(
//                               "Travessa Tiradentes, 154 - Centro",
//                               style: TextStyle(
//                                 color: Color(0xff146FF5),
//                               ),
//                             ),
//                             avatar: const Icon(
//                               Icons.location_on,
//                               color: Color(0xff146FF5),
//                             ),
//                             backgroundColor: Colors.white,
//                             side: const BorderSide(
//                                 color: Color(0xff146FF5), width: 1.5),
//                             deleteIcon: const Icon(
//                               Icons.close,
//                               color: Color(0xff146FF5),
//                             ),
//                             deleteIconColor: const Color(0xff146FF5),
//                             onDeleted: () {
//                               setState(() {
//                                 locationVisible = false;
//                               });
//                             },
//                           ),