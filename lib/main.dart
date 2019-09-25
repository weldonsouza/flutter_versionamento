import 'package:flutter/material.dart';

import 'check_version.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CheckVersion(),
      debugShowCheckedModeBanner: false,
    );
  }
}
