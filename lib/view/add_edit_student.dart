import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/student_home_controller.dart';
import '../models/student.dart';

class AddEditStudentPage extends StatelessWidget {
  final StudentHomeController studentController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  AddEditStudentPage({super.key});
  final isDark = Get.isDarkMode;
  @override
  Widget build(BuildContext context) {
    final Student? selectedStudent = Get.arguments;

    if (selectedStudent != null) {
      nameController.text = selectedStudent.name;
      ageController.text = selectedStudent.age.toString();
      gradeController.text = selectedStudent.grade;
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: Text(
          selectedStudent != null ? 'Edit Student' : 'Add Student',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: gradeController,
              decoration: const InputDecoration(
                labelText: 'Grade',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.black : Colors.white,
              ),
              onPressed: () {
                if (selectedStudent != null) {
                  studentController.updateStudent(
                    selectedStudent,
                    nameController.text,
                    int.parse(ageController.text),
                    gradeController.text,
                  );
                } else {
                  studentController.addStudent(
                    nameController.text,
                    int.parse(ageController.text),
                    gradeController.text,
                  );
                }
                Get.back();
              },
              child: Text(
                selectedStudent != null ? 'Update' : 'Add',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
