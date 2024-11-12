import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'main_page_vm.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({
    required this.child,
    super.key,
  });

  @override
  State<MainPage> createState() => _WidgetState();
}

class _WidgetState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainPageVM>().init(widget.child);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainPageVM>(context);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBarTheme(
        data: Theme.of(context).bottomNavigationBarTheme,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: SvgPicture.asset(
                  'assets/images/menu/tea.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              label: 'Чай',
              backgroundColor: const Color(0xFF4C4C4D),
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: vm.quantity != 0,
                label: vm.quantity != 0
                    ? Container(
                        width: 9,
                        height: 12,
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '${vm.quantity}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : const SizedBox(),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: SvgPicture.asset(
                    'assets/images/menu/cart.svg',
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              label: Strings.cart,
              backgroundColor: const Color(0xFF4C4C4D),
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: SvgPicture.asset(
                  'assets/images/menu/user.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              label: Strings.profile,
              backgroundColor: const Color(0xFF4C4C4D),
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: SvgPicture.asset(
                  'assets/images/menu/order.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              label: Strings.orders,
              backgroundColor: const Color(0xFF4C4C4D),
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: SvgPicture.asset(
                  'assets/images/menu/info.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              label: Strings.important,
              backgroundColor: const Color(0xFF4C4C4D),
            ),
          ],
          selectedItemColor: const Color(0xFFFFFFFF),
          unselectedItemColor: const Color(0xC0FFFFFF),
          unselectedLabelStyle: const TextStyle(
            color: Color(0xC0FFFFFF),
          ),
          backgroundColor: const Color(0xFF4C4C4D),
          selectedIconTheme: const IconThemeData(
            color: Color(0xFFFFFFFF),
          ),
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
          ),
          type: BottomNavigationBarType.fixed,
          currentIndex: vm.calculateSelectedIndex(context),
          onTap: (int index) => vm.onItemTapped(index, context),
        ),
      ),
    );
  }
}
