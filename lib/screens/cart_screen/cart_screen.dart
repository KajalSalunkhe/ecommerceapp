import 'package:ecommerceapp/constants/constants.dart';
import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:ecommerceapp/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:ecommerceapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$ ${appProvider.totalPrice().toString()}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  onPressed: () {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProductCartList();
                    appProvider.clearCart();
                    if (appProvider.getBuyProductList.isEmpty) {
                      showMessage("Cart is empty");
                    } else {
                      Routes.instance
                          .push(widget: CartItemCheckOut(), context: context);
                    }
                  },
                  title: "Checkout")
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Cart Screen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(child: Text("Empty"))
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (context, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
