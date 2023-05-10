import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:qaz_mebel/constants/theme.dart';
import 'package:qaz_mebel/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:qaz_mebel/firebase_helper/firebase_options/firebase_options.dart';
import 'package:qaz_mebel/provider/app_provider.dart';
import 'package:qaz_mebel/screens/auth_ui/welcome/welcome.dart';
import 'package:qaz_mebel/screens/custom_bottom_bar/custom_bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QazMebel',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
