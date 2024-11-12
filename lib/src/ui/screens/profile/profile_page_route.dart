import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePageRoute extends GoRoute {
  static const pageName = 'Профиль';
  static const route = '/profile';

  ProfilePageRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ProfilePageVM(
                context.read<AuthService>(),
              ),
              builder: (context, _) {
                return const ProfilePage();
              },
            ),
          ),
        );
}
