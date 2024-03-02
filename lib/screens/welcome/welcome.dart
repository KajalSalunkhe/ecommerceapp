import 'package:ecommerceapp/constants/asset_images.dart';
import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/screens/auth_ui/login/login.dart';
import 'package:ecommerceapp/screens/auth_ui/sign_up/sign_up.dart';
import 'package:ecommerceapp/widgets/primary_button/primary_button.dart';
import 'package:ecommerceapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                title: "Welome", subTitle: "Buy any item  from using App"),
            Center(
              child: Image.asset(AssetsImages.instance.welcomeImage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.inbox,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
                onPressed: () {
                  Routes.instance.push(context: context, widget: const Login());
                },
                title: "Login"),
            const SizedBox(height: 18),
            PrimaryButton(
                onPressed: () {
                  Routes.instance.push(context: context, widget: const SignUp());
                },
                title: "Sign Up"),
          ],
        ),
      ),
    );
  }
}
