import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class forgetPasword extends StatefulWidget {
  const forgetPasword({super.key});



  @override
  _forgetPaswordState createState() => _forgetPaswordState();
}

class _forgetPaswordState extends State<forgetPasword> {
  final TextEditingController emailController = TextEditingController();
  String errorMessage = '' ;
  var _email = '';

  Future<void> verifyOTP() async {
    final String email = emailController.text;
    try {

      // Send email with OTP
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,


      );

      // Navigate to the home page or display success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An email with the OTP has been sent to ${email}.'),
      ));
    } catch (e) {
      print('Error sending email: $e');
      setState(() {
        errorMessage = 'Error occurred while sending email. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Email Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            TextField(
              style: const TextStyle(color: Colors.black),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Enter Email",
                  labelStyle: const TextStyle(
                      fontFamily: 'roboto', color: Colors.black)),
            ),
            const SizedBox(height: 8.0),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: verifyOTP,
                child: const Text('Send link to Email',style: TextStyle(color: Colors.blue),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}