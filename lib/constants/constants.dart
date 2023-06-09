import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Загрузка...")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Электронная почта уже используется. Перейти на страницу входа.";
    case "account-exists-with-different-credential":
      return "Электронная почта уже используется. Перейти на страницу входа.";
    case "email-already-in-use":
      return "Электронная почта уже используется. Перейти на страницу входа.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Неправильный пароль ";
    case "ERROR_USER_NOT_FOUND":
      return "Пользователь с этим адресом электронной почты не найден.";
    case "user-not-found":
      return "Пользователь с этим адресом электронной почты не найден.";
    case "ERROR_USER_DISABLED":
      return "Пользователь отключен.";
    case "user-disabled":
      return "Пользователь отключен.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Слишком много запросов на вход в этот аккаунт.";
    case "operation-not-allowed":
      return "Слишком много запросов на вход в этот аккаунт.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Слишком много запросов на вход в этот аккаунт.";
    case "ERROR_INVALID_EMAIL":
      return "Адрес электронной почты недействителен.";
    case "invalid-email":
      return "Адрес электронной почты недействителен.";
    default:
      return "Ошибка входа. Пожалуйста, попробуйте еще раз.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Оба поля пусты");
    return false;
  } else if (email.isEmpty) {
    showMessage("Введите пароль");
    return false;
  } else if (password.isEmpty) {
    showMessage("Введите пароль");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Все поля пусты");
    return false;
  } else if (name.isEmpty) {
    showMessage("Введите Имя");
    return false;
  } else if (email.isEmpty) {
    showMessage("Введите пароль");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Введите номер телефона");
    return false;
  } else if (password.isEmpty) {
    showMessage("Введите пароль");
    return false;
  } else {
    return true;
  }
}
