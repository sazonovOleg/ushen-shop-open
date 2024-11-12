import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/screens/recovery_password/recovery_pass.dart';
import 'package:TeaShopApp/src/ui/screens/recovery_password/recovery_pass_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecoveryPassRoute extends GoRoute {
  static const pageName = 'Восстановить пароль';
  static const route = 'recovery-pass';

  RecoveryPassRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => RecoveryPassVM(
                context.read<AuthService>(),
              ),
              builder: (context, _) {
                return const RecoveryPassPage();
              },
            ),
          ),
        );
}
