import 'package:flutter/material.dart';
import 'package:flutter_in_app_purchase/screens/sign_in_screen.dart';
import 'package:flutter_in_app_purchase/screens/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => SignInScreen())),
              child: Text('Sign In'),
            ),
            SizedBox(height: 12),
            FilledButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => SignUpScreen())),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
