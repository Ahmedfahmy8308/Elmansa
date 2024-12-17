import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final bool isObscured;
  final VoidCallback toggleVisibility;
  final String? Function(String?)? validator;
  final IconData iconn;

  PasswordField({
    this.controller,
    required this.labelText,
    required this.hintText,
    required this.iconn,
    required this.isObscured,
    required this.toggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(iconn),
          suffixIcon: IconButton(
            icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class RichTextt extends StatelessWidget {
  String text1;
  String text2;
  final VoidCallback onSignUpTap;
  RichTextt(this.text1, this.text2, {required this.onSignUpTap});
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: text1,
            style: GoogleFonts.readexPro(
              fontSize: 14,
              color: Color(0xff14181B),
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
          TextSpan(
            text: text2,
            style: GoogleFonts.readexPro(
                fontSize: 14,
                color: Color(0xff4b29ef),
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xff4b29ef)),
            recognizer: TapGestureRecognizer()..onTap = onSignUpTap,
          )
        ]));
  }
}

class Button extends StatelessWidget {
  final String action;
  final VoidCallback onPressed;

  Button(this.action, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Text(
            action,
            style: GoogleFonts.readexPro(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        height: 56,
        width: double.infinity,
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final IconData iconn;
  final double? label_size;
  Color? color;
  InputField({
    required this.labelText,
    required this.hintText,
    required this.iconn,
    this.label_size,
    this.controller,
    this.keyboardType,
    this.validator,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          fillColor: color,
          prefixIcon: Icon(
            iconn,
          ),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: label_size),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

class DateOfBirthField extends StatefulWidget {
  @override
  _DateOfBirthFieldState createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      readOnly: true, // Prevent user from typing manually
      decoration: InputDecoration(
          labelText: 'Date of Birth',
          hintText: 'Select your date of birth',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      onTap: () async {
        DateTime currentDate = DateTime.now();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? currentDate,
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
