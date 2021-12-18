import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omar_task/app/modules/home/components/calender.dart';
import 'package:omar_task/app/modules/home/components/days_list.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abdelrahuman fikry's task"),
      ),
      body: Column(
        children: const [
          CalenderView(),
          DaysList(),
        ],
      ),
    );
  }
}
