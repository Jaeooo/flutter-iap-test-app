import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_in_app_purchase/screens/purchase_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    () => trySignIn(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void trySignIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Something about FCM Token

      final firestore = FirebaseFirestore.instance;

      final uid = userCredential.user!.uid;
      final userRef = firestore.collection('users').doc(uid);

      final userDoc = await userRef.get();
      final data = userDoc.data();
      final subscriptionPlan = data?['subscriptionPlan'];

      await userRef.update({'updatedAt': FieldValue.serverTimestamp()});

      debugPrint('Signed In, Current State: $subscriptionPlan');

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => PurchaseScreen()));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
