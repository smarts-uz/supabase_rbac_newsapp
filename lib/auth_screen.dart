import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home_screen.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'io.supabase.flutter://',
          onSignInComplete: (response) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ));
          },
          onSignUpComplete: (response) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
