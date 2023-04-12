import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterbook/flutterbook.dart';
import 'package:ion_mobile/ion_mobile.dart';

Organizer stepComponent() {
  return Component(
    componentName: 'Step',
    componentMarkdown:
        """# No Ion esse é o Step `UpComming`, mas pode ser  `Completed`, `Currrent`, `Disabled` e `Error` """,
    states: [
      ComponentState(
        stateName: "UpComming",
        markdown: """## O IonStep padrão """,
        codeSample: r'''
IonStepper(
  onStepChanged:(int i){},
  steps:[
    IonStep(title:'UpComming'),
  ],
);
''',
        builder: (context, c) {
          return Center(
            child: IonStepper(
              currentStep: -1,
              onStepChanged: (int i) {},
              steps: [
                IonStep(
                  title: c.text(
                    label: 'Text',
                    initial: 'Step',
                    description: 'Define the text displayed in step',
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Current",
        markdown: """## O IonStep current """,
        codeSample: r'''
IonStepper(
  currentStep:0,
  onStepChanged:(int i){},
  steps:[
    IonStep(title:'Current'),
  ],
);
''',
        builder: (context, c) {
          return Center(
            child: IonStepper(
              currentStep: 0,
              onStepChanged: (int i) {},
              steps: [
                IonStep(
                  title: c.text(
                    label: 'Text',
                    initial: 'Step',
                    description: 'Define the text displayed in step',
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Completed",
        markdown: """## O IonStep error """,
        codeSample: r'''
IonStepper(
  onStepChanged:(int i){},
  steps:[
    IonStep(
      title:'Step',
      state: IonStepState.completed,
    ),
  ],
);
''',
        builder: (context, c) {
          return Center(
            child: IonStepper(
              currentStep: 1,
              onStepChanged: (int i) {},
              steps: [
                IonStep(
                  title: c.text(
                    label: 'Text',
                    initial: 'Step',
                    description: 'Define the text displayed in step',
                  ),
                  state: IonStepState.completed,
                ),
              ],
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Disabled",
        markdown: """## O IonStep disabled """,
        codeSample: r'''
IonStepper(
  currentStep:0,
  onStepChanged:(int i){},
  steps:[
    IonStep(
      title:'Step',
      subtitle:'(optional)',
    ),
  ],
);
''',
        builder: (context, c) {
          return Center(
            child: IonStepper(
              currentStep: 0,
              onStepChanged: (int i) {},
              steps: [
                IonStep(
                  title: c.text(
                    label: 'Text',
                    initial: 'Step',
                    description: 'Define the text displayed in step',
                  ),
                  state: IonStepState.disabled,
                ),
              ],
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Error",
        markdown: """## O IonStep error """,
        codeSample: r'''
IonStepper(
  currentStep:-1,
  onStepChanged:(int i){},
  steps:[
    IonStep(
      title:'Step',
      state: IonStepState.error,
    ),
  ],
);
''',
        builder: (context, c) {
          return Center(
            child: IonStepper(
              currentStep: -1,
              onStepChanged: (int i) {},
              circleSize: c.number(
                label: 'circleSize',
                initial: 32.r,
                description: 'Define the circle size in step',
              ),
              steps: [
                IonStep(
                  title: c.text(
                    label: 'Text',
                    initial: 'Step',
                    description: 'Define the text displayed in step',
                  ),
                  state: IonStepState.error,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
