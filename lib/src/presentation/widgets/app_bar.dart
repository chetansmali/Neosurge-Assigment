import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  CustomAppBar({required this.name});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
