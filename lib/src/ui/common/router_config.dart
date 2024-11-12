import 'package:TeaShopApp/src/ui/screens/about/about_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/cart/cart_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/main/main_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_route.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_route.dart';
import 'package:TeaShopApp/src/ui/screens/user_orders/user_order_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ShopPageRoute.route,
  routes: [
    MainPageRoute(
      shellNavigatorKey: _shellNavigatorKey,
      routesBase: [
        ShopPageRoute(),
        CartPageRoute(),
        AuthPageRoute(),
        ProfileInfoRoute(),
        ProfilePageRoute(),
        UserOrdersRoute(),
        AboutPageRoute(),
      ],
    )
  ],
);
