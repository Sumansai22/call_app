import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            subtitle: Text("Coming soon"),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => logout(context),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Developer"),
            subtitle: Text("Flutter Internship Project"),
          ),
        ],
      ),
    );
  }
}