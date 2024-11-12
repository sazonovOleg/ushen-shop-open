import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/infrastructure/firebase/firebase_analytics.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_vm.dart';
import 'package:TeaShopApp/src/ui/screens/shop_product/shop_product_route.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShopPageRoute extends GoRoute {
  static const pageName = 'Магазин';
  static const route = '/shop';

  ShopPageRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ShopPageVM(
                context.read<TeaService>(),
                context.read<FirebaseAnalyticsProxy>(),
              ),
              builder: (context, _) {
                final params = {'teaType': '', 'teaSubtype': ''};

                return ShopPage(
                  teaType: params['teaType'] ?? '',
                  teaSubtype: params['teaSubtype'] ?? '',
                );
              },
            ),
          ),
          routes: <RouteBase>[
            ShopPageRouteV2(),
          ],
        );
}

class ShopPageRouteV2 extends GoRoute {
  static const pageName = 'Категория';
  static const route = 'category';

  ShopPageRouteV2()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ShopPageVM(
                context.read<TeaService>(),
                context.read<FirebaseAnalyticsProxy>(),
              ),
              builder: (context, _) {
                final params = state.extra as Map<String, dynamic>;

                return ShopPage(
                  teaType: params['teaType'] ?? '',
                  teaSubtype: params['teaSubtype'] ?? '',
                );
              },
            ),
          ),
          routes: <RouteBase>[
            ShopProductRoute(),
          ],
        );
}
