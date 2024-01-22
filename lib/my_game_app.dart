import 'package:flutter/material.dart';
import 'package:list_projects/spinwheel_home.dart';

class MyGameApp extends StatelessWidget {
  const MyGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpinWheelHome(),
    );
  }
}
