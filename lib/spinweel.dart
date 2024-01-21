import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;
  int spinCount = 0;

  List<int> items = [0, 15, 0, 10, 0, 5, 0, 3, 0, 1];

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
            rewards = items[selected.value];
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
          selected.add(Fortune.randomInt(0, items.length));
        });
      },
      child: Container(
        height: 40,
        width: 120,
        color: Colors.redAccent,
        child: Center(
          child: Text("SPIN"),
        ),
      ),
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

void main() {
  runApp(
    MaterialApp(
      home: SpinWheel(),
    ),
  );
}