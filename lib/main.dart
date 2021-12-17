import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  final List<Element> _elements = <Element>[];
  final GroupedItemScrollController _groupedItemScrollController =
      GroupedItemScrollController();
  late ItemPositionsListener _listener;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int groupIndex = -1;

  void initData() {
    List.generate(
      14,
      (index) => _elements.add(
        Element(
          DateTime.now().add(Duration(days: index)),
          'No appointments',
        ),
      ),
    );
  }

  void onScrollChanges(int? index) {
    if (_elements.isNotEmpty && index != null) {
      if (mounted && index != groupIndex) {
        setState(() {
          _focusedDay = _elements[index].date;
          _selectedDay = _elements[index].date;
          groupIndex = index;
        });
      }
    }
  }

  @override
  void initState() {
    initData();
    _listener = ItemPositionsListener.create();
    _listener.itemPositions.addListener(() {
      final index = _listener.itemPositions.value.first.index ~/ 2;
      onScrollChanges(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abdelrahuman fikry's task"),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 13)),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
              final index = _elements.indexWhere(
                (element) =>
                    element.date.day == focusedDay.day &&
                    element.date.month == focusedDay.month &&
                    element.date.year == focusedDay.year,
              );
              _groupedItemScrollController.scrollTo(
                index: index,
                duration: const Duration(
                  milliseconds: 800,
                ),
                curve: Curves.fastOutSlowIn,
              );
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: StickyGroupedListView<Element, DateTime>(
              elements: _elements,
              order: StickyGroupedListOrder.ASC,
              itemScrollController: _groupedItemScrollController,
              groupBy: (Element element) => DateTime(
                  element.date.year, element.date.month, element.date.day),
              groupComparator: (DateTime value1, DateTime value2) =>
                  value1.compareTo(value2),
              itemComparator: (Element element1, Element element2) =>
                  element2.date.compareTo(element2.date),
              floatingHeader: false,
              itemPositionsListener: _listener,
              indexedItemBuilder: (_, Element element, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 20.0,
                  ),
                  child: Text(
                    element.name,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                );
              },
              groupSeparatorBuilder: (Element element) {
                bool isToday = false;
                String txt = DateFormat('EEE, MMM ,d').format(element.date);
                if (element.date.day == DateTime.now().day &&
                    element.date.month == DateTime.now().month &&
                    element.date.year == DateTime.now().year) {
                  isToday = true;
                  txt =
                      'Today, ' + DateFormat('EEE MMM d').format(element.date);
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
                              fontWeight:
                                  isToday ? FontWeight.bold : FontWeight.w600,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Element {
  DateTime date;
  String name;

  Element(this.date, this.name);
}
