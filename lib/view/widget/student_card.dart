import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/student_home_controller.dart';
import '../../models/student.dart';
import '../add_edit_student.dart';

class StudentCard extends StatelessWidget {
  const StudentCard(
      {super.key, required this.student, required this.studentHomeController});
  final Student student;
  final StudentHomeController studentHomeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 200,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(.2),
      ),
      child: Column(
        children: [
          userData('Name: ${student.name}', Icons.person, 22, context),
          const SizedBox(
            height: 7,
          ),
          userData('Age: ${student.age}', Icons.numbers, 18, context),
          const SizedBox(
            height: 7,
          ),
          userData('Grade: ${student.grade}', Icons.grade, 18, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    Get.to(AddEditStudentPage(), arguments: student),
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      confirmDeletePopup(student, studentHomeController)),
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> confirmDeletePopup(
      Student student, StudentHomeController studentHomeController) {
    return Get.defaultDialog(
      title: "Confirm Deletion",
      content: const Text(
        "Are you sure you want to delete this student?",
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          studentHomeController.deleteStudent(student);
          Get.back();
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.white),
        ),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10, backgroundColor: Colors.white),
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget userData(
      String data, IconData? icon, double? fontSize, BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(data,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                )),
          ),
        ],
      ),
    );
  }
}
