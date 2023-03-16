import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ion_mobile/design/colors.dart';
import 'package:ion_mobile/design/iconography/ion_icons.dart';
import 'package:ion_mobile/design/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  GridView _buildCalendar(DateTime currentDate) {
    int year = currentDate.year;
    int month = currentDate.month;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int daysInPrevMonth = DateTime(year, month, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final int dayOfMonth = index - DateTime(year, month, 1).weekday + 1;
        final DateTime currentDate = DateTime(year, month, dayOfMonth);

        if (dayOfMonth <= 0 || dayOfMonth > daysInMonth) {
          final int dayOfMonthToShow = dayOfMonth <= 0
              ? dayOfMonth + daysInPrevMonth
              : dayOfMonth - daysInMonth;
          return SizedBox(
            height: 24.h,
            width: 24.w,
            child: Center(
              child: Text(
                dayOfMonthToShow.toString(),
                style: const IonTextStyleBody(
                  ionFontWeight: IonFontWeight.regular,
                  ionFontStyle: IonFontStyle.normal,
                  ionTextColor: IonTextColor.neutral5,
                  ionFontSize: IonBodyFontSizeHeight.regular,
                ),
              ),
            ),
          );
        } else {
          return InkWell(
            onTap: () => _selectDate(currentDate),
            child: Container(
              height: 24.h,
              width: 24.w,
              color: IonMainColors.primary1,
              child: Center(
                child: Text(
                  dayOfMonth.toString(),
                  style: const IonTextStyleBody(
                    ionFontWeight: IonFontWeight.regular,
                    ionFontStyle: IonFontStyle.normal,
                    ionTextColor: IonTextColor.neutral7,
                    ionFontSize: IonBodyFontSizeHeight.regular,
                  ),
                ),
              ),
            ),
          );
        }
      },
      itemCount: 7 * 6,
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

  final List<String> daysName = [
    'DOM',
    'SEG',
    'TER',
    'QUA',
    'QUI',
    'SEX',
    'SAB',
  ];

  Future<DateTime?> showIonDatePicker() async {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            content: SizedBox(
              width: 312.w,
              height: 304.h,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _previousYear()),
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.left3,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67.h,
                            width: 5.67.w,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _previousMonth()),
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.left2,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67.h,
                            width: 5.67.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                        width: 140.w,
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
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.right2,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67.h,
                            width: 5.67.w,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _nextYear()),
                        child: Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              color: IonMainColors.neutral4,
                            ),
                          ),
                          child: SvgPicture.asset(
                            IonIcons.right3,
                            package: 'ion_mobile',
                            color: IonMainColors.primary6,
                            height: 9.67.h,
                            width: 5.67.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 16.h,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: daysName.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(
                            right: daysName[i] != daysName.last ? 17.w : 0),
                        child: Text(
                          daysName[i],
                          style: const IonTextStyleBody(
                            ionFontStyle: IonFontStyle.normal,
                            ionFontWeight: IonFontWeight.regular,
                            ionFontSize: IonBodyFontSizeHeight.small,
                            ionTextColor: IonTextColor.neutral5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(child: _buildCalendar(_currentDate)),
                ],
              ),
            ),
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
