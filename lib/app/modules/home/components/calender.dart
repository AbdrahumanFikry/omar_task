import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omar_task/app/modules/home/controllers/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends GetView<HomeController> {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 13)),
        focusedDay: controller.focusedDay.value,
        calendarFormat: controller.calendarFormat.value,
        selectedDayPredicate: (day) {
          return isSameDay(controller.selectedDay.value, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(controller.selectedDay.value, selectedDay)) {
            controller.selectedDay.value = selectedDay;
            controller.focusedDay.value = focusedDay;
          }
          final index = controller.daysList.indexWhere(
            (element) =>
                element.date.day == focusedDay.day &&
                element.date.month == focusedDay.month &&
                element.date.year == focusedDay.year,
          );
          controller.groupedItemScrollController.scrollTo(
            index: index,
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.fastOutSlowIn,
          );
        },
        onFormatChanged: (format) {
          if (controller.calendarFormat.value != format) {
            controller.calendarFormat.value = format;
          }
        },
        onPageChanged: (focusedDay) {
          controller.focusedDay.value = focusedDay;
        },
      ),
    );
  }
}
