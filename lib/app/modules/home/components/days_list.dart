import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omar_task/app/data/models/days_appointment_model.dart';
import 'package:omar_task/app/modules/home/components/day_header.dart';
import 'package:omar_task/app/modules/home/controllers/home_controller.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'day_appointments.dart';

class DaysList extends GetView<HomeController> {
  const DaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: controller.daysList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : StickyGroupedListView<DayAppointmentsModel, DateTime>(
              elements: controller.daysList,
              order: StickyGroupedListOrder.ASC,
              itemScrollController: controller.groupedItemScrollController,
              groupBy: (DayAppointmentsModel element) => DateTime(
                  element.date.year, element.date.month, element.date.day),
              groupComparator: (DateTime value1, DateTime value2) =>
                  value1.compareTo(value2),
              itemComparator: (DayAppointmentsModel dayAppointment1,
                      DayAppointmentsModel dayAppointment2) =>
                  dayAppointment1.date.compareTo(dayAppointment2.date),
              floatingHeader: false,
              itemPositionsListener: controller.positionsListener,
              indexedItemBuilder:
                  (_, DayAppointmentsModel dayAppointment, index) =>
                      DayAppointments(
                appointments: dayAppointment.appointments,
              ),
              groupSeparatorBuilder: (DayAppointmentsModel dayAppointment) =>
                  DayHeader(
                dayAppointment: dayAppointment,
              ),
            ),
    );
  }
}
