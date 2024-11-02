import 'package:elite/features/auth/presentation/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: signOut,child: const Icon(Icons.logout_rounded),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user!.uid, style: Theme.of(context).textTheme.titleLarge),
            Text(user!.email!, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }

  signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SignupPage()));
  }
}
