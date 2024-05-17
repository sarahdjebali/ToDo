import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/View/home_page.dart';

import 'forgot_password.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool isLoginPage = false;
  bool isLoading = false;
  bool _isObscure = true;

  void startAuthentication() async {
    setState(() {
      isLoading = true;
    });

    final formState = _formkey.currentState;
    if (formState != null) {
      final validity = formState.validate();
      FocusScope.of(context).unfocus();
      if (validity) {
        formState.save();
        await submitForm(_email, _password, _username);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitForm(
      String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    try {
      if (isLoginPage) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          duration:
          const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 100),
              Center(
                child: Container(
                  child: isLoginPage
                      ? const Text("Welcome Back ! ",
                      style: TextStyle(fontSize: 25, color: Colors.black))
                      : const Text("Let's create an Account for You ! ",
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isLoginPage)
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey('username'),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Incorrect username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value ?? '';
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFDBFFB7), width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFDBFFB7), width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Enter username ",
                            labelStyle: const TextStyle(
                                fontFamily: 'roboto', color: Colors.black),
                          ),
                        ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value?.isEmpty ??
                              true || !(value?.contains('@') ?? false)) {
                            return 'Incorrect Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFDBFFB7), width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFDBFFB7), width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: "Enter Email",
                          labelStyle: const TextStyle(
                              fontFamily: 'roboto', color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: _isObscure,
                        // Use the state to toggle password visibility
                        keyboardType: TextInputType.visiblePassword,
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Incorrect password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFDBFFB7), width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFDBFFB7), width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: "Enter Password",
                          labelStyle: const TextStyle(
                              fontFamily: 'roboto', color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure =
                                !_isObscure; // Toggle password visibility
                              });
                            },
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              // Change icon based on password visibility state
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 70,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            startAuthentication();
                          },
                          child: isLoginPage
                              ? const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16, color: Colors.black),
                          )
                              : const Text(
                            "SignUp",
                            style: TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                        child: isLoginPage
                            ? const Text("Not a member  ? Register Now ",
                            style: TextStyle(color: Colors.blue))
                            : const Text("Already a member ? Login Now ",
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Visibility(
                        visible: isLoginPage,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const forgetPasword()));
                          },
                          child: const Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w900,
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button

                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}