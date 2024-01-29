// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RegistrationPage extends StatefulWidget {
//   // ... your existing code

//   @override
//   State<RegistrationPage> createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();

//   final String formEndpoint = "https://formspree.io/your_formspree_endpoint";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... your existing code

//       ElevatedButton(
//         onPressed: () async {
//           String name = nameController.text;
//           String email = emailController.text;
//           String phone = phoneController.text;

//           // Create a map with the form data
//           Map<String, String> formData = {
//             'name': name,
//             'email': email,
//             'phone': phone,
//           };

//           // Make a POST request to Formspree
//           http.Response response = await http.post(
//             Uri.parse(formEndpoint),
//             body: formData,
//           );

//           // Handle the response as needed
//           print('Formspree response: ${response.body}');
//         },
//         child: Text('Submit Information'),
//       ),
//     );
//   }
// }
