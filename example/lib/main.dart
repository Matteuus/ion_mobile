import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/ion_mobile.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(ScreenUtilInit(
    designSize: const Size(360, 800),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IonChipSelected(
              text: 'Loren Ipsum, 100 - Centro',
              icon: IonIcons.localization,
              onDeleted: () => debugPrint('teste'),
            ),
            const SizedBox(
              height: 10,
            ),
            IonButtonPrimary(
              icon: IonIcons.clip,
              iconColor: Colors.white,
              text: "Salvar",
              height: 48.h,
              width: 296.w,
              isLoading: isLoading,
              onTap: () => setState(() {
                isLoading = !isLoading;
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            IonButtonSecundary(
              icon: IonIcons.localization,
              text: "Salvar",
              height: 48.h,
              width: 296.w,
              isLoading: isLoading,
              onTap: () => setState(() {
                isLoading = !isLoading;
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
        categories: [
          WidgetbookCategory(
            name: 'widgets',
            widgets: [
              WidgetbookComponent(
                name: 'Button',
                useCases: [
                  WidgetbookUseCase(
                    name: 'Primary',
                    builder: (context) => Center(
                      child: IonButtonPrimary(
                        text: context.knobs
                            .text(label: "Entrar", initialValue: "Salvar"),
                        height: 48.h,
                        width: 296.w,
                        isLoading: false,
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
        themes: [
          WidgetbookTheme(
            name: 'Light',
            data: ThemeData.light(),
          ),
          WidgetbookTheme(
            name: 'Dark',
            data: ThemeData.dark(),
          ),
        ],
        appInfo: AppInfo(name: 'Ion Mobile'),
        devices: [
          Apple.iPhone12,
          Apple.iPhone13,
          Samsung.s10,
          Samsung.s21ultra,
        ]);
  }
}
