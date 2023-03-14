import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/design/typography.dart';

class IonDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime lastDate;
  final Function(DateTime) onSelectedDate;

  const IonDatePicker({
    super.key,
    required this.initialDate,
    required this.lastDate,
    required this.onSelectedDate,
  });

  @override
  State<IonDatePicker> createState() => _IonDatePickerState();
}

class _IonDatePickerState extends State<IonDatePicker> {
  late DateTimeRange _selectedDate;
  late DateTime _currentDate;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate;
  }

  void _selectDate(DateTime date) {
    if (startDate == null) {
      startDate = date;
    } else if (endDate == null) {
      endDate = date;
      if (startDate!.isAfter(endDate!)) {
        var temp = startDate;
        startDate = endDate;
        endDate = temp;
      }
      setState(() {
        _selectedDate = DateTimeRange(start: startDate!, end: endDate!);
      });
    } else {
      startDate = date;
      endDate = null;
      setState(() {});
    }
  }

  void _previousMonth() {
    _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
  }

  void _nextMonth() {
    int year = _currentDate.year;
    if (_currentDate.year > widget.lastDate.year) return;
    int month = _currentDate.month + 1;
    if (month > 12) {
      month = 1;
      year++;
    }
    _currentDate = DateTime(year, month);
  }

  void _previousYear() {
    _currentDate = DateTime(_currentDate.year - 1, _currentDate.month);
  }

  void _nextYear() {
    if (_currentDate.year == widget.lastDate.year) return;
    _currentDate = DateTime(_currentDate.year + 1, _currentDate.month);
  }

  Table _buildCalendar(DateTime currentDate) {
    int year = currentDate.year;
    int month = currentDate.month;
    const style = IonTextStyleBody(
      ionFontWeight: IonFontWeight.medium,
      ionFontStyle: IonFontStyle.normal,
      ionTextColor: IonTextColor.neutral6,
      ionFontSize: IonBodyFontSizeHeight.small,
    );

    const styleDate = IonTextStyleBody(
      ionFontWeight: IonFontWeight.regular,
      ionFontStyle: IonFontStyle.normal,
      ionTextColor: IonTextColor.neutral7,
      ionFontSize: IonBodyFontSizeHeight.regular,
    );

    const styleDatePreviusAndNext = IonTextStyleBody(
      ionFontWeight: IonFontWeight.regular,
      ionFontStyle: IonFontStyle.normal,
      ionTextColor: IonTextColor.neutral5,
      ionFontSize: IonBodyFontSizeHeight.regular,
    );

    int weekdayOfFirstDay = DateTime(year, month, 1).weekday;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int daysInPrevMonth = DateTime(year, month, 0).day;
    int daysInNextMonth = DateTime(year, month + 2, 0).day;

    List<TableRow> rows = [];

    int currentDay = 1 - weekdayOfFirstDay;

    for (int i = 0; i < 6; i++) {
      List<Widget> rowChildren = [];

      for (int j = 0; j < 7; j++) {
        if (currentDay < 1 || currentDay > daysInMonth) {
          if (currentDay <= 0) {
            rowChildren.add(
              Center(
                child: Text(
                  (currentDay + daysInPrevMonth).toString(),
                  style: styleDatePreviusAndNext,
                ),
              ),
            );
          } else {
            final date = DateTime(year, month, (currentDay - daysInMonth));
            rowChildren.add(
              InkWell(
                onTap: () => _selectDate(date),
                child: Center(
                  child: Text(
                    (currentDay - daysInMonth).toString(),
                    style: styleDatePreviusAndNext,
                  ),
                ),
              ),
            );
          }
        } else {
          final date = DateTime(year, month, currentDay);
          rowChildren.add(
            InkWell(
              onTap: () => _selectDate(date),
              child: Center(
                child: Text(
                  currentDay.toString(),
                  style: styleDate,
                ),
              ),
            ),
          );
        }
        currentDay++;
      }

      rows.add(
        TableRow(
          children: rowChildren,
        ),
      );

      if (currentDay > daysInMonth + daysInNextMonth) {
        break;
      }
    }

    return Table(
      textBaseline: TextBaseline.alphabetic,
      children: [
        const TableRow(
          children: [
            Center(child: Text('DOM', style: style)),
            Center(child: Text('SEG', style: style)),
            Center(child: Text('TER', style: style)),
            Center(child: Text('QUA', style: style)),
            Center(child: Text('QUI', style: style)),
            Center(child: Text('SEX', style: style)),
            Center(child: Text('SAB', style: style)),
          ],
        ),
        ...rows,
      ],
    );
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

  Future<DateTime?> showIonDatePicker() async {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            content: SizedBox(
              height: 314.0,
              width: 312,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _previousYear()),
                        child: Container(
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
                            height: 17,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _previousMonth()),
                        child: Container(
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
                            height: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                        width: 140,
                        child: Center(
                          child: Text(
                            '${monthNames[_currentDate.month - 1]} - ${_currentDate.year}',
                            style: const IonTextStyleBody(
                              ionFontStyle: IonFontStyle.normal,
                              ionFontWeight: IonFontWeight.medium,
                              ionFontSize: IonBodyFontSizeHeight.large,
                              ionTextColor: IonTextColor.neutral8,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _nextMonth()),
                        child: Container(
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
                            height: 17,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _nextYear()),
                        child: Container(
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
                            height: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildCalendar(_currentDate),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Fechar',
                  style: IonTextStyleBody(
                    ionFontWeight: IonFontWeight.medium,
                    ionFontStyle: IonFontStyle.normal,
                    ionFontSize: IonBodyFontSizeHeight.regular,
                    ionTextColor: IonTextColor.primary6,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  debugPrint(_selectedDate.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IonMainColors.primary6,
                ),
                child: const Text('Pronto'),
              ),
            ],
          ),
        );
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showIonDatePicker();
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _dateController,
          decoration: const InputDecoration(
            labelText: 'Data',
          ),
        ),
      ),
    );
  }
}
