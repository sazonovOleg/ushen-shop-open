import 'package:TeaShopApp/src/di/providers.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/infrastructure/firebase/firebase_analytics.dart';
import 'package:TeaShopApp/src/infrastructure/hive/hive_adapters.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';
import 'package:TeaShopApp/src/ui/app/app.dart';
import 'package:TeaShopApp/src/ui/app/app_vm.dart';
import 'package:TeaShopApp/src/ui/common/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  RegisterHive().registerHiveAdapters();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    Providers(
      child: ChangeNotifierProvider(
        create: (context) => AppVm(
          context.read<MainTheme>(),
          context.read<SharedPref>(),
          context.read<TeaService>(),
          context.read<FirebaseAnalyticsProxy>(),
        ),
        builder: (context, _) {
          return const App();
        },
      ),
    ),
  );
}
