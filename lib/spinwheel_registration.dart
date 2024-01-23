import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        width: 300,
        child: Column(
          children: [
            DrawerHeader(child: ListTile()),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                ), // Icon for Settings
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white,
                ),
                ),
              onTap: () {
                // Add your settings logic here
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white, // Set the icon color to white
              ),
              title: Text(
                'About',
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
              ),
              onTap: () {
                // Add your about page logic here
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Add your registration logic here
                String name = nameController.text;
                String email = emailController.text;
                String password = phoneController.text;

                // Display registration information (for demonstration purposes)
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Registration Successful'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Name: $name'),
                          Text('Email: $email'),
                          Text('Phone Number: $password'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit Information'),
            ),
          ],
        ),
      ),
    );
  }
}

