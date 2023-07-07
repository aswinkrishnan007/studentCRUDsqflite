import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import '../models/student.dart';

class StudentHomeController extends GetxController {
  final Database database;
  var students = <Student>[].obs;

  StudentHomeController(this.database) {
    fetchStudents();

    initTheme();
  }

  initTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    isDark.value = Get.isDarkMode;
  }

  Future<void> fetchStudents() async {
    final List<Map<String, dynamic>> maps = await database.query('Students');
    students.value = List.generate(
      maps.length,
      (index) => Student(
        id: maps[index]['id'],
        name: maps[index]['name'],
        age: maps[index]['age'],
        grade: maps[index]['grade'],
      ),
    );
  }

  Future<void> addStudent(String name, int age, String grade) async {
    final id = await database.insert('Students', {
      'name': name,
      'age': age,
      'grade': grade,
    });
    students.add(Student(id: id, name: name, age: age, grade: grade));
    fetchStudents();
  }

  Future<void> updateStudent(
      Student student, String name, int age, String grade) async {
    student.name = name;
    student.age = age;
    student.grade = grade;
    await database.update(
      'Students',
      {
        'name': name,
        'age': age,
        'grade': grade,
      },
      where: 'id = ?',
      whereArgs: [student.id],
    );
    fetchStudents();
  }

  Future<void> deleteStudent(Student student) async {
    students.remove(student);
    await database.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  RxBool isDark = Get.isDarkMode.obs;

  void changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDarkMode;
    try {
      isDarkMode = !prefs.getBool('isDarkMode')!;

      prefs.setBool('isDarkMode', isDarkMode);
      Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
      isDark.value = isDarkMode;
    } catch (e) {
      isDarkMode = true;
      prefs.setBool('isDarkMode', isDarkMode);
      Get.changeThemeMode(ThemeMode.dark);
      isDark.value = isDarkMode;
    }
  }
}
