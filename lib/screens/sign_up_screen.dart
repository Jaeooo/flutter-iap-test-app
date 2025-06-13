import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_app_purchase/screens/purchase_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 16),
              FilledButton(
                onPressed:
                    () => trySignUp(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void trySignUp({required String email, required String password}) async {
    try {
      final UserCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserCredential.user!.uid)
          .set({
            'username': 'test-user',
            'email': email,
            'uid': UserCredential.user?.uid,
            'type': 'email',
            'subscriptionPlan': 'free',
            'createdAt': FieldValue.serverTimestamp(),
          });

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => PurchaseScreen()));
    } catch (e) {
      rethrow;
    }
  }
}
