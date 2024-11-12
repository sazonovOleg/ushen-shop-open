import 'package:TeaShopApp/src/ui/screens/about/about_page.dart';
import 'package:TeaShopApp/src/ui/screens/about/about_page_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AboutPageRoute extends GoRoute {
  static const pageName = 'Важно';
  static const route = '/about';

  AboutPageRoute()
      : super(
    path: route,
    name: pageName,
    pageBuilder: (context, state) => NoTransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => AboutPageVM(),
        builder: (context, _) {
          return const AboutPage();
        },
      ),
    ),
  );
}
