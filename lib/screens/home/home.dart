import 'package:ecommerceapp/constants/routes.dart';
import 'package:ecommerceapp/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerceapp/models/category_model/category_model.dart';
import 'package:ecommerceapp/provider/app_provider.dart';
import 'package:ecommerceapp/screens/category_view/category_view.dart';
import 'package:ecommerceapp/screens/product_details/product_details.dart';
import 'package:ecommerceapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    // TODO: implement initState
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    // print(categoriesList);
    print(productModelList);
    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchList = [];

  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopTitles(title: "E-Commerce", subTitle: ""),
                        TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchProducts(value);
                          },
                          decoration: InputDecoration(hintText: "Search..."),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? Center(
                          child: Text("Category is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: categoriesList
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CupertinoButton(
                                        onPressed: () {
                                          Routes.instance.push(
                                              widget: CategoryView(
                                                  categoryModel: e),
                                              context: context);
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(e.image),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                  // SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Top Selling",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12),
                  searchController.text.isNotEmpty && searchList.isEmpty
                      ? Center(
                          child: Text("No product found"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                padding: const EdgeInsets.only(bottom: 50),
                                shrinkWrap: true,
                                primary: false,
                                // itemCount: bestProducts.length,
                                itemCount: searchList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: 0.7,
                                        crossAxisCount: 2),
                                itemBuilder: (ctx, index) {
                                  // ProductModel singleProduct = bestProducts[index];
                                  ProductModel singleProduct =
                                      searchList[index];

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Image.network(
                                          singleProduct.image,
                                          height: 100,
                                          width: 100,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Price: \$${singleProduct.price}"),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context: context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : productModelList.isEmpty
                              ? Center(
                                  child: Text("Best Products is Empty"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    shrinkWrap: true,
                                    primary: false,
                                    // itemCount: bestProducts.length,
                                    itemCount: productModelList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 20,
                                            childAspectRatio: 0.7,
                                            crossAxisCount: 2),
                                    itemBuilder: (ctx, index) {
                                      // ProductModel singleProduct = bestProducts[index];
                                      ProductModel singleProduct =
                                          productModelList[index];

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            Image.network(
                                              singleProduct.image,
                                              height: 100,
                                              width: 100,
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            Text(
                                              singleProduct.name,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                                "Price: \$${singleProduct.price}"),
                                            const SizedBox(
                                              height: 30.0,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: 140,
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Routes.instance.push(
                                                      widget: ProductDetails(
                                                          singleProduct:
                                                              singleProduct),
                                                      context: context);
                                                },
                                                child: const Text(
                                                  "Buy",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                  SizedBox(height: 12),
                ],
              ),
            ),
    );
  }
}

// List<String> categoriesList = [
//   "https://www.pngkey.com/png/full/20-201517_image-freeuse-taco-vegetable-design-food-vector-free.png",
//   "https://b.kisscc0.com/20180815/evw/kisscc0-indian-cuisine-traditional-food-dosa-thali-5b746dec128126.2098670515343569720758.png",
//   "https://www.nicepng.com/png/full/168-1681394_food-vegetables-fruits-and-sweets-vector-png-different.png",
//   "https://b.kisscc0.com/20180815/evw/kisscc0-indian-cuisine-traditional-food-dosa-thali-5b746dec128126.2098670515343569720758.png",
//   "https://4vector.com/i/free-vector-fast-food-lunch-dinner-ff-menu-clip-art_112798_Fast_Food_Lunch_Dinner_Ff_Menu_clip_art_hight.png",
// ];

// List<ProductModel> bestProducts = [
//   ProductModel(
//     image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//     id: "1",
//     name: "Apple",
//     price: 200,
//     description:
//         "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//     isFavourite: false,
//   ),
//   ProductModel(
//       image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//       id: "2",
//       name: "Apple",
//       price: 200,
//       description:
//           "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//       isFavourite: false),
//   ProductModel(
//     image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//     id: "3",
//     name: "Apple",
//     price: 200,
//     description:
//         "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//     id: "4",
//     name: "Apple",
//     price: 200,
//     description:
//         "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//     id: "5",
//     name: "Apple",
//     price: 200,
//     description:
//         "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//     isFavourite: false,
//   ),
//   ProductModel(
//     image: "https://pngfre.com/wp-content/uploads/apple-43-1024x1015.png",
//     id: "6",
//     name: "Apple",
//     price: 200,
//     description:
//         "This is a Apple. good for health. you can eat.This is a Apple. good for health. you can eat.",
//     isFavourite: false,
//   )
// ];
