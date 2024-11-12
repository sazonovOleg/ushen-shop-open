import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageVM extends ChangeNotifier with ErrorHandler {
  AboutPageVM();

  void init() {}

  final List<String> firstTextList = [
    'После оформления заказа мы свяжемся с вами, для подтверждения заказа.',
    'Мы пришлем вам реквизиты для оплаты.',
  ];

  final List<String> secondTextList = [
    'На данный момент у нас действует доставка Почтой России.',
    'В ближайшее время у нас появится доставка CDEK и Boxberry.',
  ];

  final List<String> fourthListText = [
    'Если у вас появились какие-то проблемы при работе с приложением сообщите нам ushen.shop@gmail.com мы будем благодарны:) и свяжемся с вами.',
  ];

  final List<String> fiveListText = [
    'При покупке от 5000₽ - скидка 5%',
    'При покупке от 10000 - скидка 7%',
    'При покупке от 25000₽ - скидка 10%',
  ];

  Future<void> openLink(String link) async {
    final uri =  Uri.parse(link);
    await launchUrl(uri);
  }
}
