import 'package:flutter/material.dart';

AppBar appBar(String label) => AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
