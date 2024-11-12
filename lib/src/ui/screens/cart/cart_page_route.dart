import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/ui/screens/cart/cart_page.dart';
import 'package:TeaShopApp/src/ui/screens/cart/cart_page_vm.dart';
import 'package:TeaShopApp/src/ui/screens/order/order_page_route.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartPageRoute extends GoRoute {
  static const pageName = 'Корзина';
  static const route = '/cart';

  CartPageRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider.value(
              value: CartPageVM(
                context.read<CartService>(),
                context.read<UserOrdersService>(),
                context.read<CartBus>(),
                context.read<AuthService>(),
              ),
              child: const CartPage(),
            ),
          ),
          routes: [
            OrderPageRoute(),
          ],
        );
}
