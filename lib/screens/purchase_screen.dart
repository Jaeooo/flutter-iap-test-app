import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_in_app_purchase/in_app_purchase/iap_manager.dart';
import 'package:flutter_in_app_purchase/screens/onboarding_screen.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  String? _subscriptionPlan;

  @override
  void initState() {
    super.initState();
    // _initialize();
  }

  // void _initialize() async {
  //   IAPManager.instance.bindPurchaseStream();

  //   await IAPManager.instance.restorePurchases();

  //   _syncPlan();
  // }

  @override
  void dispose() {
    // IAPManager.instance.disposePurchaseStream();
    super.dispose();
  }

  // void _syncPlan() async {
  //   _subscriptionPlan = await IAPManager.instance.getSubscriptionPlan();

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // _syncPlan();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_subscriptionPlan ?? 'Fetching..'),
            SizedBox(height: 12),
            // FilledButton(
            //   onPressed: () {
            //     IAPManager.instance.initiateSubscriptionPayment(
            //       'flutterIAP.basicmonth',
            //     );
            //   },
            //   child: Text('Monthly Plan'),
            // ),
            // SizedBox(height: 12),
            // FilledButton(
            //   onPressed: () {
            //     IAPManager.instance.initiateSubscriptionPayment(
            //       'flutterIAP.basicyear',
            //     );
            //   },
            //   child: Text('Yearly Plan'),
            // ),
            SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => OnboardingScreen()),
                  (_) => false,
                );
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
