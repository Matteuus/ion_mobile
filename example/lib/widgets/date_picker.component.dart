import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterbook/flutterbook.dart';
import 'package:ion_mobile/ion_mobile.dart';

Organizer datePickerComponent() {
  return Component(componentName: 'Date Picker', states: [
    ComponentState(
      stateName: "Date Picker",
      builder: (context, c) {
        return Center(
            child: IonDatePicker(
          initialDate: DateTime.now(),
          lastDate: DateTime(2024),
          onSelectedDate: (date) {},
        ));
      },
    ),
  ]);
}
