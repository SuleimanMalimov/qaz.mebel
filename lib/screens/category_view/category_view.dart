import 'package:flutter/material.dart';
import 'package:qaz_mebel/models/category_model/category_model.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/product_model/product_model.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
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
                  const SizedBox(height: kToolbarHeight*1),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(
                          widget.categoryModel.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text(" "),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
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
                                  height: 280,
                                  width: 280,
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
                                    children: [
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Image.network(
                                        singleProduct.image,
                                        height: 120,
                                        width: 120,
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                                        child: Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        "${singleProduct.price} тг",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
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
                                            "Подробнее",
                                          ),
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
}
