import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterbook/flutterbook.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/ion_mobile.dart';

Organizer buttonComponent() {
  return Component(
    componentName: 'Button',
    componentMarkdown:
        """# No Ion o botão por padrão é o `primary`, porém poder ser o `IonButtonSecundary`, `IonButtonGhost` e o `IonButtonDashed` """,
    states: [
      ComponentState(
        stateName: "Primary",
        markdown: """## A Primary kind of IonButton """,
        codeSample: r'''
Button.primary(
  child: Text('Primary Button'),
  onPressed: () {},
);
''',
        builder: (context, c) {
          return Center(
            child: IonButtonPrimary(
              isDanger: c.boolean(label: 'isDanger', initial: false),
              ionIcon: c.list(
                  label: 'icon',
                  description: "Set an icon to the button",
                  initial: "",
                  list: [
                    ListItem(title: "Pencil", value: IonIcons.pencil),
                    ListItem(title: "Close", value: IonIcons.close),
                    ListItem(
                        title: "Localization", value: IonIcons.localization)
                  ],
                  value: "Icone"),
              text: c.text(
                  label: 'text',
                  description: 'Define the text displayed in button',
                  initial: 'Button'),
              onTap: () {},
              disabled: c.boolean(
                  label: 'disabled',
                  description: "check behaviour when the button is disabled",
                  initial: false),
              height: c.number(
                label: 'height',
                initial: 48.h,
                min: 24.h,
                max: 60.h,
              ),
              width:
                  c.number(label: 'width', initial: 48.w, min: 24.w, max: 60.w),
              isLoading: c.boolean(
                  label: 'loading',
                  description: 'check behaviour when is loading',
                  initial: false),
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Secundary",
        markdown: """## A Secundary kind of IonButton """,
        codeSample: r'''
Button.primary(
  child: Text('Primary Button'),
  onPressed: () {},
);
''',
        builder: (context, c) {
          return Center(
            child: IonButtonSecundary(
              isDanger: c.boolean(label: 'isDanger', initial: false),
              ionIcon: c.list(
                  label: 'icon',
                  initial: "",
                  list: [
                    ListItem(title: "Pencil", value: IonIcons.pencil),
                    ListItem(title: "Close", value: IonIcons.close),
                    ListItem(
                        title: "Localization", value: IonIcons.localization)
                  ],
                  value: "Icone"),
              text: c.text(
                  label: 'text',
                  description: 'Define the text displayed in button',
                  initial: 'Button'),
              onTap: () {},
              disabled: c.boolean(
                  label: 'disabled',
                  description: "check behaviour when the button is disabled",
                  initial: false),
              height: c.number(
                label: 'height',
                initial: 48.h,
                min: 24.h,
                max: 60.h,
              ),
              width:
                  c.number(label: 'width', initial: 48.w, min: 24.w, max: 60.w),
              isLoading: c.boolean(
                  label: 'loading',
                  description: 'check behaviour when is loading',
                  initial: false),
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Ghost",
        markdown: """## The Ghost kind of IonButton """,
        codeSample: r'''
Button.primary(
  child: Text('Primary Button'),
  onPressed: () {},
);
''',
        builder: (context, c) {
          return Center(
            child: IonButtonGhost(
              isDanger: c.boolean(label: 'isDanger', initial: false),
              ionIcon: c.list(
                  label: 'icon',
                  description: "Set an icon to the button",
                  initial: "",
                  list: [
                    ListItem(title: "Pencil", value: IonIcons.pencil),
                    ListItem(title: "Close", value: IonIcons.close),
                    ListItem(
                        title: "Localization", value: IonIcons.localization)
                  ],
                  value: "Icone"),
              text: c.text(
                  label: 'text',
                  description: 'Define the text displayed in button',
                  initial: 'Button'),
              onTap: () {},
              disabled: c.boolean(
                  label: 'disabled',
                  description: "check behaviour when the button is disabled",
                  initial: false),
              height: c.number(
                label: 'height',
                initial: 48.h,
                min: 24.h,
                max: 60.h,
              ),
              width:
                  c.number(label: 'width', initial: 48.w, min: 24.w, max: 60.w),
              isLoading: c.boolean(
                  label: 'loading',
                  description: 'check behaviour when is loading',
                  initial: false),
            ),
          );
        },
      ),
      ComponentState(
        stateName: "Dashed",
        markdown: """## The Dashed kind of IonButton """,
        codeSample: r'''
Button.primary(
  child: Text('Primary Button'),
  onPressed: () {},
);
''',
        builder: (context, c) {
          return Center(
            child: IonButtonDashed(
              isDanger: c.boolean(label: 'isDanger', initial: false),
              ionIcon: c.list(
                  label: 'icon',
                  description: "Set an icon to the button",
                  initial: "",
                  list: [
                    ListItem(title: "Pencil", value: IonIcons.pencil),
                    ListItem(title: "Close", value: IonIcons.close),
                    ListItem(
                        title: "Localization", value: IonIcons.localization)
                  ],
                  value: "Icone"),
              text: c.text(
                  label: 'text',
                  description: 'Define the text displayed in button',
                  initial: 'Button'),
              onTap: () {},
              disabled: c.boolean(
                  label: 'disabled',
                  description: "check behaviour when the button is disabled",
                  initial: false),
              height: c.number(
                label: 'height',
                initial: 48.h,
                min: 24.h,
                max: 60.h,
              ),
              width:
                  c.number(label: 'width', initial: 48.w, min: 24.w, max: 60.w),
              isLoading: c.boolean(
                  label: 'loading',
                  description: 'check behaviour when is loading',
                  initial: false),
            ),
          );
        },
      ),
    ],
  );
}
