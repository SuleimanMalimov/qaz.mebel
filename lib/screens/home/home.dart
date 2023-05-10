import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qaz_mebel/constants/routes.dart';
import 'package:qaz_mebel/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:qaz_mebel/models/category_model/category_model.dart';
import 'package:qaz_mebel/provider/app_provider.dart';
import 'package:qaz_mebel/screens/about_us/about_us.dart';
import 'package:qaz_mebel/screens/category_view/category_view.dart';
import 'package:qaz_mebel/screens/delivery_screen/delivery_screen.dart';
import 'package:qaz_mebel/screens/guarantee_screen/guarantee_screen.dart';
import 'package:qaz_mebel/screens/product_details/product_details.dart';
import 'package:qaz_mebel/screens/search_screen/search_screen.dart';
import 'package:qaz_mebel/widgets/top_titles/top_titles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/product_model/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  List<ProductModel> productModelListSale = [];

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
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelListSale = await FirebaseFirestoreHelper.instance.getSaleProducts();

    productModelListSale.shuffle();
    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/i_10.jpg',
      'assets/images/i_11.jpg',
      'assets/images/i_12.jpg',
      'assets/images/i_13.jpg',
    ];
    final List<Widget> imageSliders = imgList.map((item) => Container(child: Container(margin: EdgeInsets.all(2.0),
      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.fill, width: 800.0),
          ],
        ),
      ),
    ),)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset("assets/images/logo6.png",width: 140),
        actions: [
          IconButton(
            onPressed: () async {
              final String telephoneNumber = '+77081253609';
              final String telephoneUrl = 'tel:$telephoneNumber';
              if (await canLaunch(telephoneUrl)) {
                await launch(telephoneUrl);
              } else {
                throw 'Could not launch $telephoneUrl';
              }
            },
            icon: const Icon(Icons.call, color: Color(0xfff89c2e), size: 30,),
          ),
          const SizedBox(width: 2),
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScreen()),
              )
            },
            icon: const Icon(Icons.search, color: Color(0xfff89c2e), size: 30,),),
          const SizedBox(width: 10),
        ],
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
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.5,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: imageSliders,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GuaranteeScreen()),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: ListTile(
                            leading: Image (image: AssetImage("assets/images/guarantee.png"),width: 50, fit:BoxFit.cover, ),
                            title: Text("Гарантия и возврат", style: TextStyle(color: Colors.black87,fontSize: 16, fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeliveryScreen()),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: ListTile(
                            leading: Image (image: AssetImage("assets/images/delivery.png"),width: 50, fit:BoxFit.cover, ),
                            title: Text("Доставка и оплата", style: TextStyle(color: Colors.black87,fontSize: 16, fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          "Каталог",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Категории пусты"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.white,
                                            elevation: 3.0,
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
                                          Text(
                                            e.name,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Хит-продаж",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(child: Text("Пусто"))
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          productModelList.length,
                              (index) {
                            ProductModel singleProduct = productModelList[index];
                            return Container(
                              width: 180,
                              height: 260,
                              margin: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.0),
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
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0,),
                  const Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Распродажа",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  productModelListSale.isEmpty
                      ? const Center(child: Text("Пусто"))
                      : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          productModelListSale.length,
                              (index) {
                            ProductModel singleProduct = productModelListSale[index];
                            return Container(
                              width: 180,
                              height: 260,
                              margin: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.0),
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
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0,),
                ],
              ),
            ),
    );
  }

}
