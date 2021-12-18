import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omar_task/app/data/models/days_appointment_model.dart';

class DayHeader extends StatelessWidget {
  final DayAppointmentsModel dayAppointment;

  const DayHeader({
    required this.dayAppointment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isToday = false;
    String txt = DateFormat('EEE, MMM ,d').format(dayAppointment.date);
    if (dayAppointment.date.day == DateTime.now().day &&
        dayAppointment.date.month == DateTime.now().month &&
        dayAppointment.date.year == DateTime.now().year) {
      isToday = true;
      txt = 'Today, ' + DateFormat('EEE MMM d').format(dayAppointment.date);
    } else {
      isToday = false;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                txt,
                style: TextStyle(
                  color: isToday ? Colors.blue : Colors.grey[800],
                  fontSize: 16,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
