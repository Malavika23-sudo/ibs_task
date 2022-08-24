import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';
import 'views/employee_add_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      initialRoute: EmployeeAddScreen.routeName,
      routes: routes,
    );
  }
}


