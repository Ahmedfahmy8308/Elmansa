import 'dart:typed_data';

import 'package:elmanasa/view/screens/public_page.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

//malak
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formRegisterKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _parentphoneController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isObscured = true;
  File? _selectedImage;
  Uint8List? _image;

  // Make Sure the email is in the database
  Future<bool> checkEmailExists(String email) async {
    // Replace this with your backend logic
    final List<String> allowedEmails = [
      "example@domain.com",
      "student@school.edu"
    ];
    return allowedEmails.contains(email);
  }

  pickImage() async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return await image.readAsBytes();
      } else {
        print('No Image Selected');
        return null;
      }
    } else {
      print('Access denied');
      return null;
    }
  }

  void selectImage() async {
    Uint8List? img = await pickImage();
    if (img != null) {
      setState(() {
        _image = img;
      });
    } else {
      print('No image was selected');
    }
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
                // width: 400,
                //  height: 870,
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
                    child: Form(
                      key: _formRegisterKey,
                      child: Column(
                        children: [
                          _image != null
                              ? GestureDetector(
                                  onTap: selectImage,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(255, 144, 158, 217),
                                    backgroundImage: MemoryImage(_image!),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: selectImage,
                                  child: CircleAvatar(
                                    radius: 50,
                                    child: Icon(Icons.camera_alt,
                                        size: 50, color: Colors.black),
                                  ),
                                )

                          // GestureDetector(
                          //   onTap: _pickImage,
                          //   child: CircleAvatar(
                          //     radius: 50,
                          //     backgroundColor: Color.fromARGB(255, 144, 158, 217),
                          //     backgroundImage: _selectedImage != null
                          //         ? FileImage(_selectedImage!)
                          //         : null,
                          //     child: _selectedImage == null
                          //         ? Icon(Icons.camera_alt,
                          //             size: 50, color: Colors.black)
                          //         : null,
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.all(24),
                          //   decoration: BoxDecoration(
                          //     color: Color(0xff4b29ef),
                          //     borderRadius: BorderRadius.circular(360),
                          //   ),
                          //   width: 80,
                          //   height: 80,
                          //   child: Icon(
                          //     Icons.note_alt,
                          //     color: Colors.white,
                          //     size: 48,
                          //   ),
                          // ),
                          ,
                          Text(
                            'Welcome!',
                            style: GoogleFonts.readexPro(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff14181b),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Please enter your details to sign Up.',
                              style: GoogleFonts.readexPro(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff14181b),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  labelText: 'First\nName',
                                  label_size: 15,
                                  hintText: 'First',
                                  iconn: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'First name is\nrequired';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: InputField(
                                  labelText: 'Middle\nName',
                                  hintText: 'Middle',
                                  iconn: Icons.person,
                                  label_size: 14,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Last name i\nrequired';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: InputField(
                                  labelText: 'Last\nName',
                                  hintText: 'Last',
                                  iconn: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Last name is\nrequired';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          DateOfBirthField(),
                          InputField(
                            controller: _phoneController,
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                            iconn: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              } else if (value.length != 11) {
                                return 'Phone number must be exactly 11 digits';
                              }
                              return null;
                            },
                          ),
                          InputField(
                            controller: _parentphoneController,
                            labelText: 'Parent Phone Number',
                            hintText: 'Enter your Parent phone number',
                            iconn: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              } else if (value.length != 11) {
                                return 'Phone number must be exactly 11 digits';
                              } else if (value == _parentphoneController.text) {
                                return "Your Phone and your parent phone can't match";
                              }
                              return null;
                            },
                          ),
                          InputField(
                            controller: _ssnController,
                            labelText: 'National Id',
                            hintText: 'Enter your National Id',
                            iconn: Icons.badge,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'National Id is required';
                              } else if (value.length != 14) {
                                return 'Phone number must be exactly 14 digits';
                              }
                              return null;
                            },
                          ),
                          InputField(
                            controller: _emailController,
                            labelText: 'Email Address',
                            hintText: 'Enter your email',
                            iconn: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          PasswordField(
                            controller: _passwordController,
                            labelText: 'Create Password',
                            hintText: 'Enter your password',
                            iconn: Icons.password,
                            isObscured: _isObscured,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            toggleVisibility: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                          PasswordField(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            iconn: Icons.password,
                            isObscured: _isObscured,
                            toggleVisibility: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            validator: (value) {
                              if (value != _passwordController.text ||
                                  _passwordController.text.isEmpty ||
                                  value == null) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     if (_formRegisterKey.currentState!.validate()) {
                          //       final emailExists =
                          //           await checkEmailExists(_emailController.text);
                          //       if (emailExists) {
                          //         // Proceed with registration
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //               content: Text('Registration successful!')),
                          //         );
                          //       } else {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //               content: Text('Email not found in database')),
                          //         );
                          //       }
                          //     }
                          //   },
                          //   child: Text('Register'),
                          // ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button('Sign Up', onPressed: () async {
                                if (_formRegisterKey.currentState != null &&
                                    _formRegisterKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PublicPage()));
                                }
                              })),
                          RichTextt("Already have an account ? ", 'Sign In',
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
        ));
  }
}
