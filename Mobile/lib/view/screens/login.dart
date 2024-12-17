import 'package:elmanasa/view/screens/Home.dart';
import 'package:elmanasa/view/screens/public_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'register.dart';
import 'package:elmanasa/helper/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool remember_me = false;
  bool _isObscured = true;
// Controllers
// Controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Mock function to authenticate user (You can replace it with real API call)
  Future<bool> authenticateUser(String email, String password) async {
    // Example of mock database check
    // You should replace this with real authentication logic from your database
    if (email == "test@example.com" && password == "password123") {
      return true; // Authentication successful
    } else {
      return false; // Authentication failed
    }
  }

  void _login() async {
    if (_formSignInKey.currentState?.validate() ?? false) {
      String email = "user email here"; // Get email from form field
      String password = "password here"; // Get password from form field

      bool isAuthenticated = await authenticateUser(email, password);

      if (isAuthenticated) {
        // Proceed with login success actions (like navigating to another screen)
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublicPage())); // Navigation to Home
      } else {
        // Show alert if credentials are incorrect
        _showErrorDialog('Invalid email or password!');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 144, 158, 217),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.5, 1.4),
              colors: [
                Color(0xffF2F2F2),
                Color(0xff4B39EF),
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: 400,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 60,
                    spreadRadius: 20,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff1f4f8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Color(0xff4b29ef),
                          borderRadius: BorderRadius.circular(360),
                        ),
                        width: 80,
                        height: 80,
                        child: Icon(
                          Icons.note_alt,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      Text(
                        'Welcome back!',
                        style: GoogleFonts.readexPro(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff14181b),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Please enter your details to sign in.',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff14181b),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InputField(
                          // title: 'Email Address',

                          labelText: 'Email',
                          hintText: "Enter your email",
                          iconn: Icons.email,
                          controller: _emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: PasswordField(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          iconn: Icons.lock,
                          isObscured: _isObscured,
                          toggleVisibility: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          controller: _passwordController,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: remember_me,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      remember_me = value!;
                                    });
                                  }),
                              Text(
                                'Remember Me',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle forgot password
                            },
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.readexPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4b29ef),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xff4b29ef),
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Button('Sign In', onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }),
                      ),
                      RichTextt("Don't have an account yet? ", 'Sign Up',
                          onSignUpTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
