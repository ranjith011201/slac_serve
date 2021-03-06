import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'providers/user.dart';

import 'screens/homeFeed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomeFeed();
            } else {
              return Registration();
            }
          },
        ),
      ),
    ),
  );
}

// class ScreensController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<UserProvider>(context);
//     switch (auth.status) {
//       case Status.Uninitialized:
//         return Splash();
//       case Status.Unauthenticated:
//       case Status.Authenticating:
//         return Registration();
//       case Status.Authenticated:
//         return HomeFeed();
//       default:
//         return Registration();
//     }
//   }
// }
