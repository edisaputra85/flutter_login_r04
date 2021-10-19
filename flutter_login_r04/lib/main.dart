import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';
import 'register.dart';
import 'setting.dart';
import 'tambahtugas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/dashboard': (context) => Dashboard(),
          '/setting': (context) => Setting(),
          '/tambahtugas': (context) => TambahTugas(),
        });
  }
}
