import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_page.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileInfoRoute extends GoRoute {
  static const pageName = 'Данные о профиле';
  static const route = '/profile-info';

  ProfileInfoRoute()
      : super(
          path: route,
          name: pageName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (context) => ProfileInfoVM(
                context.read<ProfileService>(),
                context.read<AuthService>(),
                context.read<AuthBus>(),
              ),
              builder: (context, _) {
                return const ProfileInfoPage();
              },
            ),
          ),
        );
}
