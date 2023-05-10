import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GuaranteeScreen extends StatelessWidget {
  const GuaranteeScreen({super.key});

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
          "Гарантия и возврат",
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
                    "ГАРАНТИЯ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "  QAZMEBEL гарантирует качество предлагаемых к реализации товаров и обязуется в течение действия гарантийного срока устранять недостатки, за которые отвечает продавец (изготовитель или исполнитель). Мы рекомендуем осуществлять сборку товаров (мебели) с помощью квалифицированных специалистов. Претензии в отношении недостатков товара, возникших в результате самостоятельной или неквалифицированной сборки, удовлетворению не подлежат. Такая сборка может представлять серьезную опасность для жизни и здоровья людей, и сохранности прочего имущества.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "КАЧЕСТВО",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "  Мы работаем только с проверенными поставщиками мебели, чтобы продавать нашим клиентам только качественные товары. Мы предоставляем нашим клиентам возможность возврата товара надлежащего качества в течение 30 дней, независимо от причины возврата. Возврат товара надлежащего качества проводится, если указанный товар не был в употреблении, сохранены его товарный вид, потребительские свойства, пломбы, фабричные ярлыки.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "НАДЕЖНОСТЬ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "  Мы работаем на рынке мебели с 2003 г. Наш офис и склад открыты для наших покупателей – мы всегда рады проконсультировать клиентов не только по телефону, но и лично. Прозрачность нашей работы, простота заказа и широкая география продаж даёт нам право с уверенностью заявлять о надежности нашего интернет-магазина. Мы постоянно работаем над качеством обслуживания наших клиентов, наши специалисты могут проконсультировать по любому вопросу.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
