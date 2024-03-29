import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_getx/db/db_helper.dart';
import 'package:todo_getx/services/theme_services.dart';
import 'package:todo_getx/ui/home_page.dart';
import 'package:todo_getx/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner:false,
      title: 'To Do',
      theme: Themes.lightMode,
      darkTheme: Themes.darkMode,
      themeMode: ThemeServices().theme,
      home: const MyHomePage()
    );
  }
}

