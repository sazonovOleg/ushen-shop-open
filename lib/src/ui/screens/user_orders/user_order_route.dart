import 'package:TeaShopApp/src/features/orders/domain/user_orders_bus.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/ui/screens/user_orders/user_orders_page.dart';
import 'package:TeaShopApp/src/ui/screens/user_orders/user_orders_page_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserOrdersRoute extends GoRoute {
  static const pageName = 'Заказы';
  static const route = '/user_orders';

  UserOrdersRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => UserOrdersPageVM(
                context.read<UserOrdersService>(),
                context.read<UserOrdersBus>(),
              ),
              builder: (context, _) {
                return const UserOrdersPage();
              },
            ),
          ),
        );
}
