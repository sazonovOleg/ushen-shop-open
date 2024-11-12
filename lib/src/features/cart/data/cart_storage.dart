import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';

import 'models/hive/cart_hive_model.dart';

class CartStorage {
  final HiveStorage _hiveStorage;
  final SharedPref _sharedPref;

  CartStorage(
    this._hiveStorage,
    this._sharedPref,
  );

  final String _cartStorageKey = 'user_cart_storage_key';
  final String _cartLength = 'cart_length';

  Future<void> saveCart(List<CartHiveModel> cartHiveModel) async {
    await _hiveStorage.saveBox(_cartStorageKey, cartHiveModel);
  }

  Future<List<CartHiveModel>> getCart() async {
    final list = await _hiveStorage.getBox(_cartStorageKey);

    return list != null ? list.cast<CartHiveModel>() : [];
  }

  Future<void> clearCart() async {
    await _hiveStorage.clearBox(_cartStorageKey);
  }

  Future<void> saveCartLength(int cartLength) async {
    await _sharedPref.setInt(_cartLength, cartLength);
  }

  Future<int?> getCartLength() async {
    return await _sharedPref.getInt(_cartLength);
  }
}
