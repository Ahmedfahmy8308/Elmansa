import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:elmanasa/view/screens/public_page.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'dart:io';

//malak
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formRegisterKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _parentphoneController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isObscured = true;
  File? _selectedImage;
  Uint8List? _image;

  Future<void> pickImage() async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _image = _selectedImage!.readAsBytesSync();
        });
      } else {
        print('Image selection cancelled or no image selected.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image')),
        );
      }
    } else {
      print('Storage permission denied.');
    }
  }

  Future<void> registerUser() async {
    if (_formRegisterKey.currentState!.validate()) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("http://localhost/api/Account/Register"),
        );

        request.fields['Student_email'] = _emailController.text;
        request.fields['Student_password'] = _passwordController.text;
        request.fields['Student_first_name'] = _fnameController.text;
        request.fields['Student_Middel_name'] = _mnameController.text;
        request.fields['Student_last_name'] = _lnameController.text;
        request.fields['Student_number'] = _phoneController.text;
        request.fields['Student_SSN'] = _ssnController.text;
        request.fields['Student_date_birth'] = _birthController.text;
        request.fields['Student_guardian_number'] = _parentphoneController.text;

        if (_selectedImage != null) {
          print('Uploading image...');
          var image = await http.MultipartFile.fromPath(
            'Student_photo',
            _selectedImage!.path,
          );
          request.files.add(image);
        }

        print('Sending request...');
        var response = await request.send();

        print('Response status: ${response.statusCode}');
        if (response.statusCode == 200) {
          print('Registration Successful');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Successful')),
          );
        } else {
          print('Registration Failed: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error during registration: ${e.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: ${e.toString()}')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 144, 158, 217),
        body: SingleChildScrollView(
          child: Container(
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
                                  onTap: pickImage,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(255, 144, 158, 217),
                                     backgroundImage:
                            _selectedImage != null ? FileImage(_selectedImage!) : null,
                        child: _selectedImage == null
                            ? Icon(Icons.camera_alt, size: 50, color: Colors.black)
                            : null,
                      
                                  ),
                                )
                              : GestureDetector(
                                  onTap: pickImage,
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
                                      return 'Middle name i\nrequired';
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
                              } else if (value == _phoneController.text) {
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
                         
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Button('Sign Up', onPressed: () async {
                                if (_formRegisterKey.currentState != null &&
                                    _formRegisterKey.currentState!.validate()) {
                                      if (_selectedImage != null) {
                                await registerUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Colors.red,
        ),
      );
    }
                                }
                              })
                              ),
                          RichTextt("Already have an account ? ", 'Sign In',
                              onSignUpTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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
