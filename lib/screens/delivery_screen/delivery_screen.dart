import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/dec1.jpg',
      'assets/images/dec2.jpg',
      'assets/images/dec3.jpg',
      'assets/images/dec4.jpg',
      'assets/images/dec5.jpg',
      'assets/images/dec6.jpg',
    ];
    final List<Widget> imageSliders = imgList.map((item) => Container(child: Container(margin: EdgeInsets.all(2.0),
      child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 800.0),
          ],
        ),
      ),
    ),)).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colo,
        title: const Text(
          "Доставка и оплата",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Column(
                children:  const [
                  Text(
                      "Стандартная доставка",
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.orange
                     ),
                   ),
                  Image (image: AssetImage("assets/images/del1.png"),width: 200, fit:BoxFit.cover, ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Доставка готовых заказов осуществляется с понедельника по субботу в любой согласованный с Вами день. ",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    " В день доставки водитель обязательно свяжется с Вами за час до прибытия.",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Доставка в городе Алматы бесплатная.",
                    style: TextStyle(
                        fontSize: 17,fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children:  const [
                  Text(
                    "Самовывоз со склада",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  Image (image: AssetImage("assets/images/del2.png"),width: 200, fit:BoxFit.cover, ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Вы можете самостоятельно забрать заказ с нашего склада:",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  Text(
                    "Казахстан, Республика Казахстан, город Алматы, Kazbiochem, Кулджинский тракт 26/2",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Режим работы склада:\nпн-пт: 09:00-18:00\nсб: 09:00-13:00\nвс: выходной",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
