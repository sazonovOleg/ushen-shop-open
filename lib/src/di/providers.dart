import 'package:TeaShopApp/src/features/auth/data/api/auth_api.dart';
import 'package:TeaShopApp/src/features/auth/data/auth_repo.dart';
import 'package:TeaShopApp/src/features/auth/data/auth_storage.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/cart/data/api/cart_api.dart';
import 'package:TeaShopApp/src/features/cart/data/cart_repo.dart';
import 'package:TeaShopApp/src/features/cart/data/cart_storage.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/orders/data/api/user_orders_api.dart';
import 'package:TeaShopApp/src/features/orders/data/user_orders_repo.dart';
import 'package:TeaShopApp/src/features/orders/data/user_orders_storage.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_bus.dart';
import 'package:TeaShopApp/src/features/orders/domain/user_orders_service.dart';
import 'package:TeaShopApp/src/features/profile/data/api/profile_api.dart';
import 'package:TeaShopApp/src/features/profile/data/profile_repo.dart';
import 'package:TeaShopApp/src/features/profile/data/profile_storage.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/features/tea/data/api/tea_api.dart';
import 'package:TeaShopApp/src/features/tea/data/tea_data_storage.dart';
import 'package:TeaShopApp/src/features/tea/data/tea_repo.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/infrastructure/api/api_client.dart';
import 'package:TeaShopApp/src/infrastructure/firebase/firebase_analytics.dart';
import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';
import 'package:TeaShopApp/src/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MainTheme>(
          create: (context) => const MainTheme(),
        ),
        Provider<HiveStorage>(
          create: (context) => HiveStorage(),
        ),
        Provider<SharedPref>(
          create: (context) => SharedPref(),
        ),
        Provider<ApiClient>(
          create: (context) => ApiClient(),
        ),
        Provider<FirebaseAnalyticsProxy>(
          create: (_) => FirebaseAnalyticsProxy(),
        ),
        Provider<CartApi>(
          create: (context) => CartApi(
            context.read<ApiClient>().dio,
          ),
        ),
        Provider<CartStorage>(
          create: (context) => CartStorage(
            context.read<HiveStorage>(),
            context.read<SharedPref>(),
          ),
        ),
        Provider<CartRepo>(
          create: (context) => CartRepo(
            context.read<CartApi>(),
            context.read<CartStorage>(),
          ),
        ),
        Provider<CartService>(
          create: (context) => CartService(
            context.read<CartRepo>(),
          ),
        ),
        Provider<UserOrdersApi>(
          create: (context) => UserOrdersApi(
            context.read<ApiClient>().dio,
          ),
        ),
        Provider<UserOrdersStorage>(
          create: (context) => UserOrdersStorage(
            context.read<HiveStorage>(),
            context.read<SharedPref>(),
          ),
        ),
        Provider<UserOrdersRepo>(
          create: (context) => UserOrdersRepo(
            context.read<UserOrdersApi>(),
            context.read<UserOrdersStorage>(),
          ),
        ),
        Provider<UserOrdersService>(
          create: (context) => UserOrdersService(
            context.read<UserOrdersRepo>(),
            context.read<CartService>(),
          ),
        ),
        Provider<ProfileApi>(
          create: (context) => ProfileApi(
            context.read<ApiClient>().dio,
          ),
        ),
        Provider<ProfileStorage>(
          create: (context) => ProfileStorage(
            context.read<HiveStorage>(),
            context.read<SharedPref>(),
          ),
        ),
        Provider<ProfileRepo>(
          create: (context) => ProfileRepo(
            context.read<ProfileApi>(),
            context.read<ProfileStorage>(),
          ),
        ),
        Provider<ProfileService>(
          create: (context) => ProfileService(
            context.read<ProfileRepo>(),
          ),
        ),
        Provider<AuthApi>(
          create: (context) => AuthApi(
            context.read<ApiClient>().dio,
          ),
        ),
        Provider<AuthStorage>(
          create: (context) => AuthStorage(
            context.read<HiveStorage>(),
            context.read<SharedPref>(),
          ),
        ),
        Provider<AuthRepo>(
          create: (context) => AuthRepo(
            context.read<AuthApi>(),
            context.read<AuthStorage>(),
          ),
        ),
        Provider<AuthService>(
          create: (context) => AuthService(
            context.read<AuthRepo>(),
          ),
        ),
        Provider<TeaApi>(
          create: (context) => TeaApi(
            context.read<ApiClient>().dio,
          ),
        ),
        Provider<TeaDataStorage>(
          create: (context) => TeaDataStorage(
            context.read<HiveStorage>(),
            context.read<SharedPref>(),
          ),
        ),
        Provider<TeaRepo>(
          create: (context) => TeaRepo(
            context.read<TeaApi>(),
            context.read<TeaDataStorage>(),
          ),
        ),
        Provider<TeaService>(
          create: (context) => TeaService(
            context.read<TeaRepo>(),
          ),
        ),
        Provider<AuthBus>(
          create: (context) => AuthBus(
            context.read<AuthService>(),
            context.read<ProfileService>(),
            context.read<UserOrdersService>(),
            context.read<CartService>(),
          ),
        ),
        Provider<UserOrdersBus>(
          create: (context) => UserOrdersBus(
            context.read<AuthService>(),
            context.read<ProfileService>(),
            context.read<UserOrdersService>(),
          ),
        ),
        Provider<CartBus>(
          create: (context) => CartBus(
            context.read<AuthService>(),
            context.read<CartService>(),
            context.read<ProfileService>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
