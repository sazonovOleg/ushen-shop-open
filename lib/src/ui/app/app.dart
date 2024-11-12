import 'package:TeaShopApp/src/constants/global_key.dart';
import 'package:TeaShopApp/src/ui/common/router_config.dart';
import 'package:TeaShopApp/src/ui/screens/main/main_page.dart';
import 'package:TeaShopApp/src/ui/screens/main/main_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_vm.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _State();
}

class _State extends State<App> {
  @override
  void initState() {
    super.initState();
    context.read<AppVm>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AppVm>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Keys.messengerKey,
      theme: vm.theme,
      routerConfig: routerConfig,
    );
  }
}
