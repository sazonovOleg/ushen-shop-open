import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page_vm.dart';
import 'package:TeaShopApp/src/ui/screens/profile/profile_page_vm.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_page.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _WidgetState();
}

class _WidgetState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfilePageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfilePageVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 15,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  Strings.profile,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            vm.isLogin ? _ProfileInfoProvider() : _AuthPageProvider(),
          ],
        ),
      ),
    );
  }
}

class _AuthPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AuthPageVM(
        context.read<AuthService>(),
        context.read<AuthBus>(),
      ),
      child: const AuthPage(),
    );
  }
}

class _ProfileInfoProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProfileInfoVM(
        context.read<ProfileService>(),
        context.read<AuthService>(),
        context.read<AuthBus>(),
      ),
      child: const ProfileInfoPage(),
    );
  }
}
