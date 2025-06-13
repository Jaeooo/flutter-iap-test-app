import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_in_app_purchase/in_app_purchase/iap_manager.dart';
import 'package:flutter_in_app_purchase/screens/onboarding_screen.dart';
import 'package:flutter_in_app_purchase/screens/purchase_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // IAPManager.initialize(
  //   IAPManagerConfig(
  //     consumableIDs: {},
  //     subscriptionIDs: {'flutterIAP.basicmonth', 'flutterIAP.basicyear'},
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter IAP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: (isLoggedIn) ? PurchaseScreen() : OnboardingScreen(),
    );
  }
}
