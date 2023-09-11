import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:newsapp/home_screen.dart';

import 'auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yrgqwqzhuyyfkwkqdrha.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlyZ3F3cXpodXl5Zmt3a3FkcmhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ0Mjc5MzIsImV4cCI6MjAxMDAwMzkzMn0.BPt3V-ByjzJeitPhU1ub0flqDsan5fXaiyLJT9l-X30',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
