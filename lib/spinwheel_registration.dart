import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _key = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  sendEmail() async {
    final Email email = Email(
      subject: 'Sign Up Form Submission',
      recipients: [
        'abokoma.antwi@meltwater.gmail.com'
      ], // Replace with your email
      body: '''
        Name: ${nameController.text}
        Email: ${emailController.text}
        Phone Number: ${phoneController.text}
      ''',
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
    // You can add a success message or navigate to a success screen here.
    print('Sent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Form sikaaaa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _key.currentState!.validate();

                  print('''
        Name: ${nameController.text}
        Email: ${emailController.text}
        Phone Number: ${phoneController.text}
      ''');
                  //sendEmail();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
