import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          "О нас",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children:  [
            const Text(
                "ДОБРО ПОЖАЛОВАТЬ В «QAZMEBEL»",
               style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.orange
               ),
             ),
            const SizedBox(
              height: 22.0,
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
              height: 20.0,
            ),
            const Text(
              "  Именно у нас Вы сможете подобрать мебель на любой вкус и бюджет. Обилие представленных моделей приятно удивит Вас своим разнообразием.»",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "  Мы предусмотрели всё, для того чтобы процесс выбора мебели доставлял нашим клиентам эстетическое удовольствие, покупка была легкой, то есть отнимала как можно меньше времени и сил. Оформив заказ на сайте, Вы получите не только качественную мебель по низким ценам, но и будете приятно удивлены оперативностью обработки заказа. С помощью нашего сайта Вы сможете создать неповторимый образ вашего дома или дополнить уже сложившийся интерьер важными деталями мебели, которые придадут Вашему жилищу особую изюминку.»",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              "  «QAZMEBEL» - это необходимый инструмент, для того чтобы превратить Ваш дом в мечту!»",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
