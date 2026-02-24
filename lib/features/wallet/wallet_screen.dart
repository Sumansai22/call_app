import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  int balance = 0;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  Future<void> loadBalance() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data()!.containsKey("balance")) {
      setState(() {
        balance = doc['balance'];
      });
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({"balance": 0}, SetOptions(merge: true));

      setState(() {
        balance = 0;
      });
    }
  }

  Future<void> addMoney() async {
    int newBalance = balance + 100;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({"balance": newBalance});

    setState(() {
      balance = newBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      body: Center(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_wallet,
                    size: 60, color: Colors.green),

                const SizedBox(height: 20),

                const Text("Your Balance",
                    style: TextStyle(fontSize: 18)),

                const SizedBox(height: 10),

                Text(
                  "₹ $balance",
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: addMoney,
                  child: const Text("Add ₹100"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}