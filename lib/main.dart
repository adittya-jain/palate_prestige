
import 'package:flutter/material.dart';
import 'package:palate_prestige/socketIO/socket_test.dart';
import 'package:provider/provider.dart';
import 'models/menu.dart';
import 'pages/pages.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Menu(),
      builder: (context, child) => MaterialApp(
       debugShowCheckedModeBanner: false,
        home: HomePage(),
      ), 
    );
  }
}
