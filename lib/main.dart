import 'package:crud_provider/list.dart';
import 'package:crud_provider/menu.dart';
import 'package:crud_provider/provider/mahasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: ((context) => MahasiswaProvider()))
      ], child: MenuPage()),
    );
  }
}
