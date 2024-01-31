import 'package:flutter/material.dart';

class SettingsHomePage extends StatelessWidget {
  const SettingsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Home Page'),
            onTap: () {
              // Navigate to Home Page settings
            },
          ),
          ListTile(
            title: const Text('Personal Information'),
            onTap: () {
              // Navigate to Personal Information settings
            },
          ),
          ListTile(
            title: const Text('Privacy and Security'),
            onTap: () {
              // Navigate to Privacy and Security settings
            },
          ),
          ListTile(
            title: const Text('Payment and Subscriptions'),
            onTap: () {
              // Navigate to Payment and Subscriptions settings
            },
          ),
        ],
      ),
    );
  }
}
