import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            child: ClipOval(
              child: new SizedBox(
                width: 180,
                height: 180,
                child: Image.asset(
                  'assets/profile1.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
