import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class SpinWheelHome extends StatefulWidget {
  const SpinWheelHome({Key? key}) : super(key: key);

  @override
  State<SpinWheelHome> createState() => _SpinWheelHomeState();
}

class _SpinWheelHomeState extends State<SpinWheelHome> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;
  int spinCount = 0;

  List<dynamic> items = [
    "Try Again",
    "Free Lunch",
    11,
    0,
    5,
    "Milk Pack",
    0,
    3,
    0,
    "Tom Brown",
    10,
    "New Balance Shoes",
    0,
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFortuneWheel(),
            const SizedBox(height: 20.0),
            buildSpinButton(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildFortuneWheel() {
    return SizedBox(
      height: 300,
      child: FortuneWheel(
        selected: selected.stream,
        animateFirst: false,
        items: [
          for (int i = 0; i < items.length; i++)
            FortuneItem(child: Text(items[i].toString())),
        ],
        onAnimationEnd: () {
          setState(() {
            rewards = items[selected.value] is int ? items[selected.value] : 0;
            spinCount++;

            // Check if the user has spun 10 times
            if (spinCount % 10 == 0) {
              rewards += 10;
              showSnackBar("Congratulations! You just won an additional 10 Cedis!");
            }

            // Check if the user has spun 20 times
            if (spinCount % 20 == 0) {
              rewards += 15;
              showSnackBar("Amazing! You just won an additional 15 Cedis!");
            }
          });

          showSnackBar("You just won $rewards Cedis!");
        },
      ),
    );
  }

  Widget buildSpinButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          int selectedIndex;

          if (spinCount == 9) { // Check for the tenth spin
            if (Random().nextDouble() < 0.4) { // 40% probability for highest value
              selectedIndex = items.indexOf(11); // Index of the highest value
            } else {
              List<int> shuffledItems = items
                .map((item) => item is int ? items.indexOf(item) : -1)
                .toList()
                ..removeWhere((index) => index == -1);
              selectedIndex = shuffledItems.isNotEmpty
                ? Random().nextInt(shuffledItems.length)
                : 0; // Default to 0 if only text prizes are left
            }
          } else {
            List<int> shuffledItems = items
              .map((item) => item is int ? items.indexOf(item) : -1)
              .toList()
              ..removeWhere((index) => index == -1);
            selectedIndex = shuffledItems.isNotEmpty
              ? Random().nextInt(shuffledItems.length)
              : 0; // Default to 0 if only text prizes are left
          }
          selected.add(selectedIndex);
        });
      },
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.money), label: "TopUp"),
        BottomNavigationBarItem(
          icon: Icon(Icons.money_off_rounded),
          label: "CashOut",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        print("Selected Index: $value");

        if (value == 2) {
          navigateToRegistrationPage();
        }
      },
      currentIndex: 0,
    );
  }

 void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void navigateToRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: Text('This is the Registration Page'),
      ),
    );
  }
}