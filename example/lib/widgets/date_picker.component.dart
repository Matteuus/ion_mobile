import 'package:flutter/material.dart';
import 'package:flutterbook/flutterbook.dart';
import 'package:ion_mobile/ion_mobile.dart';

Organizer datePickerComponent() {
  final TextEditingController dateController = TextEditingController();
  return Component(
    componentName: 'Date Picker',
    states: [
      ComponentState(
        stateName: "Date Picker",
        markdown: """## A Simple DatePicker of IonDatePicker """,
        codeSample: r'''
showIonDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2025),
                selectedDate: selectedDate,
              );
''',
        builder: (context, c) {
          DateTime selectedDate = DateTime.now();
          return GestureDetector(
            onTap: () {
              showIonDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2025),
                selectedDate: selectedDate,
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'DATA',
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
