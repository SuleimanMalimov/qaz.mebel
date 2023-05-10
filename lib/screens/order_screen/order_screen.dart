import 'package:flutter/material.dart';
import 'package:qaz_mebel/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:qaz_mebel/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Ваши заказы",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(FirebaseFirestoreHelper.instance.getUserOrder(),),
        // future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text("Заказов нету"),
            );
          }
          
          return Padding(
            padding: const EdgeInsets.only(bottom:50.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape:  RoundedRectangleBorder(
                        side: BorderSide(color:Theme.of(context).primaryColor, width: 2.3)),
                    shape:  RoundedRectangleBorder(
                        side: BorderSide(color:Theme.of(context).primaryColor, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color: Colors.white,
                          child: Image.network(
                            orderModel.products[0].image,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 190,
                                child: Text(
                                  orderModel.products[0].name,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),

                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              orderModel.products.length > 1
                                  ? SizedBox.fromSize()
                                  : Column(
                                      children: [
                                        Text(
                                          "Количество: ${orderModel.products[0].qty.toString()}",
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                              Text(
                                "Общая стоимость: ${orderModel.totalPrice.toString()} тг",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Статус заказа: ${orderModel.status}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text("Детали"),
                             Divider(color:Theme.of(context).primaryColor),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color:Colors.white,
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  singleProduct.name,
                                                  style: const TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Количество: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Цена: ${singleProduct.price.toString()} тг",
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                     Divider(color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
