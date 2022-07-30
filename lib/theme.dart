import 'package:flutter/material.dart';

const primaryColor = Color(0xff24292f);
const secondaryColor = Colors.black54;

ThemeData get theme => ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
    );
