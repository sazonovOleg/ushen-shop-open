import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/screens/about/about_page_vm.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _WidgetState();
}

class _WidgetState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    context.read<AboutPageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AboutPageVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                'Важно',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.start,
              ),
            ),
            _TextList(title: '1. Способ оплаты.', vm.firstTextList, null),
            _TextList(title: '2. Способ доставки.', vm.secondTextList, null),
            _TextList(
              title: '3. Как с нами связаться?',
              null,
              _LinkText(
                vm: vm,
              ),
            ),
            _TextList(
              title: '4. Обратиться в поддержку.',
              null,
              _ContactSupport(
                vm: vm,
              ),
            ),
            _TextList(
                title: '5. У нас действует система скидок.',
                vm.fiveListText,
                null),
          ],
        ),
      ),
    );
  }
}

class _TextList extends StatelessWidget {
  final String title;
  List<String>? textList;
  Widget? widget;

  _TextList(
    this.textList,
    this.widget, {
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            child: textList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: textList!
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                            ),
                            child: Text(
                              e,
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : widget,
          ),
        ],
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  final AboutPageVM vm;

  const _LinkText({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Наш телефон '),
              InkWell(
                child: const Text(
                  '+79313781993',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                onTap: () => vm.openLink('tel:+79313781993'),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Text('Наша почта '),
              InkWell(
                child: const Text(
                  'ushen.shop@gmail.com',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                onTap: () => vm.openLink('mailto:ushen.shop@gmail.com'),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Text('Наш '),
              InkWell(
                child: const Text(
                  'VK',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                onTap: () => vm.openLink('https://vk.com/id851914818'),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Text('Наш  '),
              InkWell(
                child: const Text(
                  'телеграмм',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                onTap: () => vm.openLink('https://t.me/ushenshop'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactSupport extends StatelessWidget {
  final AboutPageVM vm;

  const _ContactSupport({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
        bottom: 4,
      ),
      child: RichText(
        text: TextSpan(
          text:
              'Если у вас появились какие-то проблемы при работе с приложением сообщите нам ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
          children: [
            TextSpan(
              text: 'ushen.shop@gmail.com ',
              style: const TextStyle(
                color: Colors.blueAccent,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => vm.openLink('mailto:ushen.shop@gmail.com'),
            ),
            const TextSpan(
              text: 'мы будем благодарны :) и свяжемся с вами.',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
