import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/view/student_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final databasePath = '${directory.path}/student_database.db';
  final database = await openDatabase(databasePath, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS Students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        grade TEXT
      )
    ''');
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(database, isDarkMode));
}

class MyApp extends StatelessWidget {
  final Database database;
  final bool isDarkMode;

  const MyApp(this.database, this.isDarkMode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Student App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: StudentHome(database: database),
    );
  }
}
