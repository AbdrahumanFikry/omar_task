import 'package:flutter/material.dart';

class DayAppointments extends StatelessWidget {
  final String appointments;

  const DayAppointments({
    required this.appointments,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      child: Text(
        appointments,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
