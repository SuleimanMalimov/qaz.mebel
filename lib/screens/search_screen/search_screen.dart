import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qaz_mebel/constants/routes.dart';
import 'package:qaz_mebel/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:qaz_mebel/models/category_model/category_model.dart';
import 'package:qaz_mebel/provider/app_provider.dart';
import 'package:qaz_mebel/screens/product_details/product_details.dart';
import '../../models/product_model/product_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getAllProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          "Поиск товара",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
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
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: search,
                    onChanged: (String value) {
                      searchProducts(value);
                    },
                    decoration:
                    const InputDecoration(hintText: "Что вы ищете?",
                      prefixIcon: Icon(Icons.search),
                    ),

                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 12.0,
            ),
            !isSearched()
                ? const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0),
              child: Text(
                "Результат",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : SizedBox.fromSize(),

            search.text.isNotEmpty && searchList.isEmpty
                ? const Center(
              child: Text("Товар не найден"),
            )
                : searchList.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: searchList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct =
                    searchList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                        BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            singleProduct.image,
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(height: 2.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              singleProduct.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            "${singleProduct.price} тг",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: ProductDetails(
                                    singleProduct: singleProduct,
                                  ),
                                  context: context,
                                );
                              },
                              child: const Text("Подробнее"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
                : productModelList.isEmpty
                ? const Center(
              child: Text("Пусто"),
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding:
                  const EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: productModelList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct =
                    productModelList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                        BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            singleProduct.image,
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(height: 2.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              singleProduct.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            "${singleProduct.price} тг",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(
                                  widget: ProductDetails(
                                    singleProduct: singleProduct,
                                  ),
                                  context: context,
                                );
                              },
                              child: const Text("Подробнее"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
