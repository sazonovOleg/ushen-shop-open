import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/ui/screens/main/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'main_page_vm.dart';

class MainPageRoute extends ShellRoute {
  final GlobalKey<NavigatorState> shellNavigatorKey;
  final List<RouteBase> routesBase;

  MainPageRoute({
    required this.shellNavigatorKey,
    required this.routesBase,
  }) : super(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => ChangeNotifierProvider(
            create: (buildContext) => MainPageVM(
              context.read<CartService>(),
              widget: child,
            ),
            builder: (buildContext, _) {
              return MainPage(child: child);
            },
          ),
          routes: routesBase,
        );
}
