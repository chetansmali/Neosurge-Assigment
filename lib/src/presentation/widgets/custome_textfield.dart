import 'package:flutter/material.dart';

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/$screenImageName'),
          ),
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            )
        ),
      ),
      validator: (val){
        if(val == null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}