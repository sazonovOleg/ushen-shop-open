import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page_vm.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_route.dart';
import 'package:TeaShopApp/src/ui/screens/recovery_password/recovery_pass_route.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthPageRoute extends GoRoute {
  static const pageName = 'Аутефикация';
  static const route = '/auth';

  AuthPageRoute()
      : super(
    path: route,
    name: pageName,
    pageBuilder: (context, state) => NoTransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => AuthPageVM(
          context.read<AuthService>(),
          context.read<AuthBus>(),
        ),
        builder: (context, _) {
          return const AuthPage();
        },
      ),
    ),
    routes: <RouteBase>[
      RecoveryPassRoute(),
      ProfileVerificationRoute(),
    ],
  );
}
