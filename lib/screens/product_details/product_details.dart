import 'package:ecommerceapp/constants/constants.dart';
import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/models/product_model/product_model.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/screens/cart_screen/cart_screen.dart';
import 'package:ecommerceapp/screens/check_out/check_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.singleProduct});
  final ProductModel singleProduct;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              Text(widget.singleProduct.description),
              SizedBox(height: 12),
              Row(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(qty.toString()),
                  SizedBox(width: 12),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              // Spacer(),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {
                        // AppProvider appProvider =
                        //     Provider.of<AppProvider>(context, listen: false);
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        appProvider.addCartProduct(productModel);
                        showMessage("Added to Cart");
                      },
                      child: Text("ADD TO CART"),
                    ),
                  ),
                  SizedBox(width: 24),
                  SizedBox(
                      height: 40,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleProduct.copyWith(qty: qty);
                          Routes.instance.push(
                              widget: CheckOut(
                                singleProduct: productModel,
                              ),
                              context: context);
                        },
                        child: Text("BUY"),
                      )),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
