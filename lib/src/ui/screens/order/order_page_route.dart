import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';
import 'order_page_vm.dart';

class OrderPageRoute extends GoRoute {
  static const pageName = 'Оформление заказа';
  static const route = 'order';

  OrderPageRoute()
      : super(
    path: route,
    name: pageName,
    pageBuilder: (context, state) => NoTransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => OrderPageVM(
          context.read<UserOrdersService>(),
          context.read<ProfileService>(),
          context.read<CartBus>(),
        ),
        builder: (context, _) {
          return const OrderPage();
        },
      ),
    ),
  );
}
