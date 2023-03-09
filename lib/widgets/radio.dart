import 'package:flutter/material.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/typography/body.dart';
import 'package:ion_mobile/design/typography/text_style.dart';


abstract class IonRadio<T> extends StatefulWidget {
 final T value;
 final T? groupValue;
 final String label;
 final bool selected;
 final Color color;
 final bool disabled;
 final ValueChanged<T?> onChanged;
 final Color borderColor;
 final IonTextStyle labelStyle;
 final List<IonRadioButton> items;


 const IonRadio({
   required this.value,
   super.key,
   this.groupValue,
   this.label = '',
   this.selected = false,
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
 });


 @override
 State<IonRadio<T>> createState() => _IonRadioState<T>();
}


class _IonRadioState<T> extends State<IonRadio<T>> {
 bool hasFocus = false;
 bool isHovering = false;
 Color fillColor = IonMainColors.neutral1;


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
   isHovering = hover;
   if (hover) {
     setState(() {
       fillColor = IonMainColors.primary1;
     });
   } else {
     setState(() {
       fillColor = IonMainColors.neutral1;
     });
   }
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
         child: Container(
           height: 24,
           width: 24,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(100),
             color: widget.disabled
                 ? Colors.transparent
                 : widget.groupValue == widget.value && isHovering
                     ? IonMainColors.primary1
                     : widget.groupValue == widget.value
                         ? Colors.transparent
                         : fillColor,
             border: Border.all(
               color: widget.disabled
                   ? Colors.transparent
                   : widget.groupValue == widget.value
                       ? Colors.transparent
                       : isHovering
                           ? Colors.transparent
                           : hasFocus
                               ? IonMainColors.primary5
                               : Colors.transparent,
               width: hasFocus ? 2 : 1,
             ),
           ),
           child: Center(
             child: Container(
               height: 16,
               width: 16,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: widget.disabled && widget.groupValue == widget.value
                     ? IonMainColors.neutral2
                     : widget.disabled
                         ? IonMainColors.neutral3
                         : widget.groupValue == widget.value && isHovering
                             ? IonMainColors.primary5
                             : widget.groupValue == widget.value
                                 ? IonMainColors.primary6
                                 : fillColor,
                 border: Border.all(
                   color: (widget.disabled && widget.groupValue == widget.value
                       ? Colors.transparent
                       : widget.disabled
                           ? IonMainColors.neutral4
                           : widget.groupValue == widget.value
                               ? Colors.transparent
                               : hasFocus
                                   ? IonMainColors.primary3
                                   : isHovering
                                       ? IonMainColors.primary3
                                       : IonMainColors.neutral5),
                   width: 1,
                 ),
               ),
               child: widget.groupValue == widget.value
                   ? Center(
                       child: Container(
                         height: 8,
                         width: 8,
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
                             height: 4,
                             width: 4,
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
       const SizedBox(width: 12),
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


class IonRadioButton extends IonRadio {
 const IonRadioButton({
   super.key,
   required super.value,
   super.label,
   required super.onChanged,
   required super.groupValue,
   super.disabled,
 });
}



