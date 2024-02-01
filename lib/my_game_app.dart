import 'package:flutter/material.dart';
import 'package:list_projects/spinwheel_home.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gfg Lunch Wheel',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegularPage(),
    );
  }
}
