import 'package:flutter/material.dart';

import 'screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: SignInScreen(),
    );
  }
}
