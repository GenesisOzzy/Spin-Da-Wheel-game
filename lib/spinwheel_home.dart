import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:confetti/confetti.dart';
import 'package:list_projects/premium_page.dart';
import 'package:list_projects/settings_home_page.dart';
import 'package:list_projects/spinwheel_registration.dart';


class RegularPage extends StatefulWidget {
  @override
  _RegularPageState createState() => _RegularPageState();
}

class Prize {
  final String reward;

  Prize({required this.reward});
}

class _RegularPageState extends State<RegularPage> {
  StreamController<int> selected = StreamController<int>();
  late ConfettiController _centerController;

  List<Prize> _prizes = [
    Prize(reward: '0 GHS'),
    Prize(reward: '0 GHS'),
    Prize(reward: 'Opps! Try Again'),
    Prize(reward: 'Free Lunch'),
    Prize(reward: '0 GHS'),
    Prize(reward: 'Lollypop'),
    Prize(reward: '10 GHS'),
    Prize(reward: 'Play with 5GHS'),
    Prize(reward: '5 GHS'),
    Prize(reward: '0 GHS'),
    Prize(reward: '3 GHS'),
    Prize(reward: 'Opps! Try Again'),
    Prize(reward: '1 GHS'),
    Prize(reward: '0 GHS'),
    Prize(reward: '0.50 GHS'),
  ];

  @override
  void initState() {
    super.initState();
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    selected.close();
    _centerController.dispose();
    super.dispose();
  }

  var selectedReward = "";
  var selectedColor = Colors.black; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ONYX Wheel of Fortune',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
      body: _prizes.length > 2
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    int selectedIndex = Fortune.randomInt(0, _prizes.length);
                    selected.add(selectedIndex);
                    selectedReward = _prizes[selectedIndex].reward;
                    selectedColor = _getPrizeColor(selectedIndex);
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      child: FortuneWheel(
                        selected: selected.stream,
                        items: [
                          for (var it in _prizes)
                            FortuneItem(
                              child: Text(it.reward),
                              style: FortuneItemStyle(
                                color: _getPrizeColor(_prizes.indexOf(it)),
                              ),
                            ),
                        ],
                        onAnimationEnd: () {
                          _centerController.play();
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: AlertDialog(
                                  scrollable: true,
                                  title: Text(
                                      "Hurray! You've won. Congratulations"),
                                  content: Column(
                                    children: [
                                      ConfettiWidget(
                                        confettiController: _centerController,
                                        blastDirection: pi / 2,
                                        maxBlastForce: 5,
                                        minBlastForce: 1,
                                        emissionFrequency: 0.03,
                                        numberOfParticles: 10,
                                        gravity: 0,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        selectedReward,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: selectedColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          int selectedIndex = Random().nextInt(_prizes.length);
                          selected.add(selectedIndex);
                          selectedReward = _prizes[selectedIndex].reward;
                          selectedColor = _getPrizeColor(selectedIndex);
                        });
                      },
                      backgroundColor: Colors.black,
                      label: Text(
                        'Spin Again',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PremiumPage()));
                      },
                      backgroundColor: Colors.redAccent,
                      label: Text(
                        'Play Regular with just 10GHS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(color: Colors.green),
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
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  void navigateToSettingsPage(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => SettingsHomePage()));
  }
}


  Color _getPrizeColor(int index) {
    // Colors array containing primary, secondary, and tertiary colors
    List<Color> colors = [
      Colors.redAccent,
      Color.fromARGB(255, 111, 111, 13),
      Colors.blueAccent,
      Colors.deepOrangeAccent,
      Colors.green,
      Colors.purple,
      Colors.orangeAccent,
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.redAccent,
      Colors.purpleAccent,
      Colors.blueAccent,
    ];

    return colors[index %
        colors.length]; // Repeat colors if there are more prizes than colors
  }

