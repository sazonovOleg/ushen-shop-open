import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_page.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileVerificationRoute extends GoRoute {
  static const pageName = 'Подвтерждение профиля';
  static const route = 'verify';

  ProfileVerificationRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ProfileVerificationVM(
                context.read<AuthService>(),
                context.read<AuthBus>(),
              ),
              builder: (context, _) {
                return const ProfileVerificationPage();
              },
            ),
          ),
        );
}
