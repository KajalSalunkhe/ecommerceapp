import 'package:ecommerceapp/constants/theme.dart';
import 'package:ecommerceapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerceapp/firebase_helper/firebase_options/firebase_options.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/screens/custom_bottom_bar.dart/custom_bottom_bar.dart';
import 'package:ecommerceapp/screens/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CustomBottomBar();
              }              
              return const Welcome();
            }),
      ),
    );
  }
}
