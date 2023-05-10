import 'package:flutter/material.dart';
import 'package:qaz_mebel/constants/asset_images.dart';
import 'package:qaz_mebel/constants/routes.dart';
import 'package:qaz_mebel/screens/auth_ui/login/login.dart';
import 'package:qaz_mebel/widgets/primary_button/primary_button.dart';
import 'package:qaz_mebel/widgets/top_titles/top_titles.dart';

import '../sign_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            const Text('Добро пожаловать',
              style: TextStyle(
              fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text('Премиальная мебель - это проявление вашего уникального стиля и класса.',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Center(
              child: Image.asset(
                "assets/images/welcome.png",
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            PrimaryButton(
              title: "Войти",
              onPressed: () {
                Routes.instance.push(widget: const Login(), context: context);
              },
            ),
            const SizedBox(
              height: 18.0,
            ),
            PrimaryButton(
              title: "Регистрация",
              onPressed: () {
                Routes.instance.push(widget: const SignUp(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
