import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qaz_mebel/models/product_model/product_model.dart';
import 'package:qaz_mebel/provider/app_provider.dart';

import '../../../constants/constants.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.white,
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            Text(
                                widget.singleProduct.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14
                                ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              ),
                        const SizedBox(
                          height: 5.0,
                        ),
                            Text(
                              "${widget.singleProduct.price.toString()} тг",
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                        CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    if (!appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)) {
                                      appProvider.addFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage("Добавлено в избранные");
                                    } else {
                                      appProvider.removeFavouriteProduct(
                                          widget.singleProduct);
                                      showMessage("Удалено из избранных");
                                    }
                                  },
                                  child: Text(
                                    appProvider.getFavouriteProductList
                                            .contains(widget.singleProduct)
                                        ? "Убрать с избранных"
                                        : "Добавить в избранные",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          showMessage("");
                        },
                        child: const CircleAvatar(
                          maxRadius: 13,
                          child: Icon(
                            Icons.delete,
                            size: 17,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
