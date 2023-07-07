import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/view/add_edit_student.dart';

import '../controller/student_home_controller.dart';
import 'widget/student_card.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key, required this.database}) : super(key: key);
  final Database database;

  @override
  Widget build(BuildContext context) {
    final StudentHomeController studentHomeController =
        Get.put(StudentHomeController(database));
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: studentHomeController.isDark.value
                ? Colors.black
                : Colors.white,
            title: Text(
              'Student List',
              style: TextStyle(
                  color: studentHomeController.isDark.value
                      ? Colors.white
                      : Colors.black),
            ),
            actions: [switchDarkMode(studentHomeController)],
          ),
          body: Center(
            child: ListView.builder(
              itemCount: studentHomeController.students.length,
              itemBuilder: (context, index) {
                var student = studentHomeController.students[index];
                return StudentCard(
                    student: student,
                    studentHomeController: studentHomeController);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: studentHomeController.isDark.value
                ? Colors.white
                : Colors.black,
            child: Icon(
              Icons.add,
              color: studentHomeController.isDark.value
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () => Get.to(AddEditStudentPage()),
          ),
        ));
  }

  ElevatedButton switchDarkMode(StudentHomeController studentHomeController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      onPressed: () async {
        studentHomeController.changeTheme();
      },
      child: Text(
        studentHomeController.isDark.value ? "Light Mode" : "Dark Mode",
        style: TextStyle(
            color: studentHomeController.isDark.value
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
