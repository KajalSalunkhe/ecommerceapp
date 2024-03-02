import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/screens/change_password/change_password.dart';
import 'package:ecommerceapp/screens/edit_profile/edit_profile.dart';
import 'package:ecommerceapp/screens/favourite_screen.dart/favourite_screen.dart';
import 'package:ecommerceapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  appProvider.getUserInformation.image == null
                      ? Icon(
                          Icons.person_outline,
                          size: 120,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              appProvider.getUserInformation.image!),
                          radius: 70,
                        ),
                  // : Image.network(appProvider.getUserInformation.image!),
                  Text(
                    appProvider.getUserInformation.name,
                    // "Kajal Salunkhe",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    appProvider.getUserInformation.email,
                    // "KajalSalunkhe@gmail.com",
                    // style: TextStyle(
                    //   fontSize: 22,
                    // ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 120,
                    child: PrimaryButton(
                      onPressed: () {
                        Routes.instance
                            .push(widget: EditProfile(), context: context);
                      },
                      title: "Edit Profile",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: FavouriteScreen(), context: context);
                  },
                  leading: Icon(Icons.favorite_outline),
                  title: Text("Favourite"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.info_outline),
                  title: Text("About Us"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.support_outlined),
                  title: Text("Support"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: ChangePassword(), context: context);
                  },
                  leading: Icon(Icons.change_circle_outlined),
                  title: Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Log Out"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Version 1.0.0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
