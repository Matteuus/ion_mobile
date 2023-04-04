import 'package:example/widgets/button.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbook/flutterbook.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/ion_mobile.dart';

import 'widgets/date_picker.component.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(360, 800),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        // darkTheme: ThemeData(brightness: Brightness.dark),
        // themeMode: ThemeMode.dark,
      );
    },
    child: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  int currentStep = 0;

  void onStepChanged(int index) {
    setState(() {
      currentStep = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<IonStep> steps = [
      IonStep(
        title: 'Step 1',
      ),
      IonStep(
        title: 'Step 2',
      ),
      IonStep(
        title: 'Step 3',
        subtitle: '(optional)',
        state: IonStepState.disabled,
      ),
      IonStep(title: 'Step 4', state: IonStepState.error),
      IonStep(
        title: 'Step 5',
      ),
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: IonStepper(
          currentStep: currentStep,
          onStepChanged: onStepChanged,
          steps: steps,
        ),
      ),
    ));
  }
}

// class HotreloadWidgetbook extends StatelessWidget {
//   const HotreloadWidgetbook({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Widgetbook.material(
//         categories: [
//           WidgetbookCategory(
//             name: 'widgets',
//             widgets: [
//               WidgetbookComponent(
//                 name: 'Button',
//                 useCases: [
//                   WidgetbookUseCase(
//                     name: 'Primary',
//                     builder: (context) => Center(
//                       child: IonButtonPrimary(
//                         text: context.knobs
//                             .text(label: "Entrar", initialValue: "Salvar"),
//                         height: 48.h,
//                         width: 296.w,
//                         isLoading: false,
//                         onTap: () {},
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//         themes: [
//           WidgetbookTheme(
//             name: 'Light',
//             data: ThemeData.light(),
//           ),
//           WidgetbookTheme(
//             name: 'Dark',
//             data: ThemeData.dark(),
//           ),
//         ],
//         appInfo: AppInfo(name: 'Ion Mobile'),
//         devices: [
//           Apple.iPhone12,
//           Apple.iPhone13,
//           Samsung.s10,
//           Samsung.s21ultra,
//         ]);
//   }
// }

class FlutterBookPage extends StatelessWidget {
  const FlutterBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterBook(
        //no header pode colocar ion by brisatech com a logo ou alguma coisa do tipo
        headerPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        categories: [
          Category(
            categoryName: 'Ion',
            organizers: [
              Folder(
                folderName: 'Navigation',
                organizers: [
                  buttonComponent(),
                ],
              ),
              Folder(
                folderName: 'Data Entry',
                organizers: [
                  datePickerComponent(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
