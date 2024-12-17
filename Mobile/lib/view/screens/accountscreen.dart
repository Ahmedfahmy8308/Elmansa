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

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObscured = true;
  File? _selectedImage;
  Uint8List? _image;
  String? photoUrl = "assets/images/me.jpg"; // Static image path

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image')),
        );
      }
    } else {
      print('Storage permission denied.');
    }
  }

  Future<void> registerUser() async {
    if (_formRegisterKey.currentState!.validate() && _selectedImage != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("http://localhost/api/Account/Register"),
        );

        request.fields['Student_email'] = _emailController.text;
        _emailController.text = "malak";
        request.fields['Student_password'] = _passwordController.text;
        request.fields['Student_first_name'] = _fnameController.text;
        request.fields['Student_Middel_name'] = _mnameController.text;
        request.fields['Student_last_name'] = _lnameController.text;
        request.fields['Student_number'] = _phoneController.text;
        request.fields['Student_SSN'] = _ssnController.text;
        request.fields['Student_date_birth'] = _birthController.text;
        request.fields['Student_guardian_number'] = _parentphoneController.text;

        var image = await http.MultipartFile.fromPath(
          'Student_photo',
          _selectedImage!.path,
        );
        request.files.add(image);

        var response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Successful')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Registration Failed: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please ensure all fields are valid and an image is selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
              height: 1200,
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
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xfff1f4f8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Form(
                    key: _formRegisterKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.readexPro(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff14181b),
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: pickImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _image != null
                                  ? MemoryImage(Uint8List.fromList(_image!))
                                  : AssetImage(photoUrl!),
                            ),
                          ),
                        ),
                        Text(
                          'Your Info',
                          style: GoogleFonts.readexPro(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff14181b),
                          ),
                        ),
                        InputField(
                          labelText: 'Malak Alsayed Ahmed',
                          hintText: 'First',
                          iconn: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First name is\nrequired';
                            }
                            return null;
                          },
                        ),
                        DateOfBirth(),
                        InputField(
                          controller: _phoneController,
                          labelText: '01111111111',
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
                          labelText: '01222222222',
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
                          labelText: '30303030303030',
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
                          labelText: 'malakalsayed@gmail.com',
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
                          labelText: '111111',
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
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Button('Save', onPressed: registerUser),
                        ),
                      ],
                    ),
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

class DateOfBirth extends StatefulWidget {
  @override
  _DateOfBirthFieldState createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirth> {
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      readOnly: true, // Prevent user from typing manually
      decoration: InputDecoration(
          labelText: '6/1/2005',
          hintText: 'Select your date of birth',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onTap: () async {
        DateTime currentDate = DateTime.now();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(1900), // Earliest date
          lastDate: currentDate, // Latest date is today
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _dobController.text =
                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date of Birth is required';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }
}
