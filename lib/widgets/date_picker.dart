import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/design/typography.dart';

Future<DateTime?> showIonDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required DateTime selectedDate,
}) async {
  DateTime currentDate = initialDate;

  void previousMonth() {
    if ((currentDate.month) == 1 && currentDate.year >= firstDate.year) return;
    currentDate = DateTime(currentDate.year, currentDate.month - 1);
  }

  void nextMonth() {
    int year = currentDate.year;
    int month = currentDate.month + 1;

    if ((month - 1) == 12 && currentDate.year >= lastDate.year) return;

    if (month > 12) {
      month = 1;
      year++;
    }
    currentDate = DateTime(year, month);
  }

  void previousYear() {
    if (currentDate.year <= firstDate.year) return;
    currentDate = DateTime(currentDate.year - 1, currentDate.month);
  }

  void nextYear() {
    if (currentDate.year >= lastDate.year) return;
    currentDate = DateTime(currentDate.year + 1, currentDate.month);
  }

  final List<String> monthNames = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  final List<String> daysName = [
    'DOM',
    'SEG',
    'TER',
    'QUA',
    'QUI',
    'SEX',
    'SAB',
  ];

// void _selectDateRange(DateTime date) {
//   if (startDate == null) {
//     startDate = date;
//   } else if (endDate == null) {
//     endDate = date;'
//     if (startDate!.isAfter(endDate!)) {
//       var temp = startDate;
//       startDate = endDate;
//       endDate = temp;
//     }
//     setState(() {
//       _selectedDate = DateTimeRange(start: startDate!, end: endDate!);
//     });
//   } else {
//     startDate = date;
//     endDate = null;
//     setState(() {});
//   }
// }

  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: SizedBox(
            width: 312,
            height: 304,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tooltip(
                      message: 'Ano interior',
                      child: InkWell(
                        onTap: () => setState(() => previousYear()),
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
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.left3,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67,
                            width: 5.67,
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Mês Anterior',
                      child: InkWell(
                        onTap: () => setState(() => previousMonth()),
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
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.left2,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67,
                            width: 5.67,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 140,
                      child: Center(
                        child: Text(
                          '${monthNames[currentDate.month - 1]} - ${currentDate.year}',
                          style: const IonTextStyleBody(
                            ionFontStyle: IonFontStyle.normal,
                            ionFontWeight: IonFontWeight.medium,
                            ionFontSize: IonBodyFontSizeHeight.large,
                            ionTextColor: IonTextColor.neutral8,
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Próximo Mês',
                      child: InkWell(
                        onTap: () => setState(() => nextMonth()),
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
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.right2,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67,
                            width: 5.67,
                          ),
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Próximo Ano',
                      child: InkWell(
                        onTap: () => setState(() => nextYear()),
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
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.right3,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67,
                            width: 5.67,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: daysName
                      .map(
                        (day) => Text(
                          day,
                          style: const IonTextStyleBody(
                            ionFontStyle: IonFontStyle.normal,
                            ionFontWeight: IonFontWeight.medium,
                            ionFontSize: IonBodyFontSizeHeight.small,
                            ionTextColor: IonTextColor.neutral6,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 24,
                  ),
                  itemBuilder: (context, index) {
                    final int dayOfMonth = index -
                        DateTime(currentDate.year, currentDate.month, 1)
                            .weekday +
                        1;
                    int daysInMonth =
                        DateTime(currentDate.year, currentDate.month + 1, 0)
                            .day;
                    int daysInPrevMonth =
                        DateTime(currentDate.year, currentDate.month, 0).day;
                    if (dayOfMonth <= 0 || dayOfMonth > daysInMonth) {
                      final int dayOfMonthToShow = dayOfMonth <= 0
                          ? dayOfMonth + daysInPrevMonth
                          : dayOfMonth - daysInMonth;
                      return Center(
                        child: Text(
                          dayOfMonthToShow.toString(),
                          style: const IonTextStyleBody(
                            ionFontWeight: IonFontWeight.regular,
                            ionFontStyle: IonFontStyle.normal,
                            ionTextColor: IonTextColor.neutral5,
                            ionFontSize: IonBodyFontSizeHeight.regular,
                          ),
                        ),
                      );
                    } else {
                      final DateTime date = DateTime(
                        currentDate.year,
                        currentDate.month,
                        dayOfMonth,
                      );
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.transparent;
                          },
                        ),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: date == selectedDate
                                  ? IonMainColors.primary6
                                  : Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                backgroundColor: date == selectedDate
                                    ? IonMainColors.primary2
                                    : Colors.transparent,
                                child: Text(
                                  dayOfMonth.toString(),
                                  style: IonTextStyleBody(
                                    ionFontWeight: IonFontWeight.regular,
                                    ionFontStyle: IonFontStyle.normal,
                                    ionTextColor: date == selectedDate
                                        ? IonTextColor.primary6
                                        : IonTextColor.neutral7,
                                    ionFontSize: IonBodyFontSizeHeight.regular,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  itemCount: 7 * 6,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
