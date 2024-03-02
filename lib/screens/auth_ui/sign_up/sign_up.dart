import 'package:ecommerceapp/constants/constants.dart';
import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerceapp/screens/custom_bottom_bar.dart/custom_bottom_bar.dart';
import 'package:ecommerceapp/screens/home/home.dart';
import 'package:ecommerceapp/widgets/primary_button/primary_button.dart';
import 'package:ecommerceapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                  title: "Create Account",
                  subTitle: "Welcome back to E- Commerce App"),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.password_sharp,
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                        print(isShowPassword);
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36),
              PrimaryButton(
                  onPressed: () async {
                    bool isVaildated = signUpVaildation(
                        email.text, password.text, name.text, phone.text);
                    if (isVaildated) {
                      bool isSigned = await FirebaseAuthHelper.instance
                          .signUp(name.text,email.text, password.text, context);
                      if (isSigned) {
                        Routes.instance.pushAndRemoveUntil(
                            widget: CustomBottomBar(), context: context);
                      }
                    }

                    // Routes.instance
                    //     .pushAndRemoveUntil(context: context, widget: Home());
                  },
                  title: "Create Account"),
              SizedBox(
                height: 24,
              ),
              Center(child: Text("Already have a Account")),
              SizedBox(height: 12),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
