import 'package:get/get.dart';
import 'package:omar_task/app/data/models/days_appointment_model.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeController extends GetxController {
  final focusedDay = Rx<DateTime>(DateTime.now());
  final selectedDay = Rxn<DateTime>();
  final groupIndex = -1.obs;
  final daysList = RxList<DayAppointmentsModel>(List.generate(
    14,
    (index) => DayAppointmentsModel(
      DateTime.now().add(Duration(days: index)),
      'No appointments',
    ),
  ));
  final calendarFormat = Rx<CalendarFormat>(CalendarFormat.week);
  late ItemPositionsListener positionsListener;
  final GroupedItemScrollController groupedItemScrollController =
      GroupedItemScrollController();

  void onScrollChanges(int? index) {
    if (daysList.isNotEmpty && index != null) {
      if (index != groupIndex) {
        focusedDay(daysList[index].date);
        selectedDay(daysList[index].date);
        groupIndex;
      }
    }
  }

  @override
  void onInit() {
    positionsListener = ItemPositionsListener.create();
    super.onInit();
  }

  @override
  void onReady() {
    positionsListener.itemPositions.addListener(() {
      final index = positionsListener.itemPositions.value.first.index ~/ 2;
      onScrollChanges(index);
    });
    super.onReady();
  }
}
