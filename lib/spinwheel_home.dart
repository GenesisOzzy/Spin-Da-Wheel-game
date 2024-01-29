import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:list_projects/spinwheel_registration.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class SpinWheelHome extends StatefulWidget {
  const SpinWheelHome({super.key});

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
    1,
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
        height: 350,
        child: FortuneWheel(
          selected: selected.stream,
          animateFirst: false,
          items: [
            FortuneItem(
                child: Text("Try Again"),
                style: FortuneItemStyle(
                  color: Colors.red,
                  // you won try again
                  //index number 0
                )),
            FortuneItem(
                child: Text("Free Lunch"),
                style: FortuneItemStyle(
                  color: Colors.blue,
                  // you won free lunch
                  //index number 1
                )),
            FortuneItem(
                child: Text("1 Cedi"),
                style: FortuneItemStyle(
                  color: Colors.yellow,
                  // you won 1 cedis
                  //index number 2
                )),
            FortuneItem(
                child: Text("0 cedis"),
                style: FortuneItemStyle(
                  color: Colors.green,
                )),
            FortuneItem(
                child: Text("5 cedis"),
                style: FortuneItemStyle(
                  color: Colors.red,
                  // you won 5 cedis
                  //index number 4
                )),
            FortuneItem(
                child: Text("Milk Pack"),
                style: FortuneItemStyle(
                  color: Colors.blue,
                  // you won milk pack
                  //index number 5
                )),
            FortuneItem(
                child: Text("0 cedis"),
                style: FortuneItemStyle(
                  color: Colors.yellow,
                  // you won 0 cedis
                  //index number 6
                )),
            FortuneItem(
                child: Text("3 cedis"),
                style: FortuneItemStyle(
                  color: Colors.green,
                  // you won 3 cedis
                  //index number 7
                )),
            FortuneItem(
                child: Text("Massage"),
                style: FortuneItemStyle(
                  color: Colors.blue,
                )),
            FortuneItem(
                child: Text("Try again"),
                style: FortuneItemStyle(
                  color: Colors.red,
                )),
            FortuneItem(
                child: Text("Happy Hour"),
                style: FortuneItemStyle(
                  color: Colors.yellow,
                )),
            FortuneItem(
                child: Text("2 cedi"),
                style: FortuneItemStyle(
                  color: Colors.green,
                )),
            FortuneItem(
                child: Text("13"),
                style: FortuneItemStyle(
                  color: Colors.blue,
                )),
          ],
          onAnimationEnd: () {
            setState(() {
              spinCount++;

              if (spinCount % 10 == 0) {
                showSnackBar(
                    "Congratulations! You just won an additional 10 Cedis!");
              }

              if (spinCount % 20 == 0) {
                showSnackBar("Amazing! You just won an additional 15 Cedis!");
              }
            });

            showSnackBar("You just won ${items[selected.value]} Cedis!");
          },
        ));
  }

  Widget buildSpinButton() {
    return ElevatedButton(
      onPressed: () {
        spinWheel();
      },
      child: Text('Spin'),
    );
  }

  void spinWheel() {
    setState(() {
      int selectedIndex;

      if (spinCount == 9) {
        if (Random().nextDouble() < 0.4) {
          selectedIndex = items.indexOf(11);
        } else {
          List<int> shuffledItems = items
              .map((item) => item is int ? items.indexOf(item) : -1)
              .toList()
            ..removeWhere((index) => index == -1);
          selectedIndex = shuffledItems.isNotEmpty
              ? Random().nextInt(shuffledItems.length)
              : 0;
        }
      } else {
        List<int> shuffledItems = items
            .map((item) => item is int ? items.indexOf(item) : -1)
            .toList()
          ..removeWhere((index) => index == -1);
        selectedIndex = shuffledItems.isNotEmpty
            ? Random().nextInt(shuffledItems.length)
            : 0;
      }
      selected.add(selectedIndex);
    });
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
      showSelectedLabels: true,
      showUnselectedLabels: true,
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
      MaterialPageRoute(builder: (context) => SignUpForm()),
    );
  }
}
