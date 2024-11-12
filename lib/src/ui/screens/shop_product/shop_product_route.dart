import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/ui/screens/shop_product/shop_product.dart';
import 'package:TeaShopApp/src/ui/screens/shop_product/shop_product_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShopProductRoute extends GoRoute {
  static const pageName = 'Продукт';
  static const route = 'shop-product';

  ShopProductRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ShopProductPageVM(
                context.read<TeaService>(),
                context.read<CartService>(),
                context.read<CartBus>(),
              ),
              builder: (context, _) {
                final params = state.extra as Map<String, dynamic>;

                return ShopProductPage(
                  teaId: params['teaId'] ?? '',
                );
              },
            ),
          ),
        );
}
