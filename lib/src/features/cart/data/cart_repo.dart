import 'package:TeaShopApp/src/features/cart/data/api/cart_api.dart';
import 'package:TeaShopApp/src/features/cart/data/cart_storage.dart';
import 'package:TeaShopApp/src/features/cart/data/models/hive/cart_hive_model.dart';
import 'package:TeaShopApp/src/features/cart/data/models/resp/cart_resp_model.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartRepo {
  final CartApi _cartApi;
  final CartStorage _cartStorage;

  CartRepo(
    this._cartApi,
    this._cartStorage,
  );

  Future<void> saveCart(int userId) async {
    final response = await _cartApi.getCart(userId);

    final cart = response
        .map(
          (e) => CartHiveModel(
            name: e.name,
            weight: e.weight,
            price: e.price,
            image: e.image,
            indexEl: e.indexEl,
            wholePack: e.wholePack,
          ),
        )
        .toList();

    await _cartStorage.saveCart(cart);
    await _cartStorage.saveCartLength(cart.length);
  }

  Future<void> reSaveCart(List<CartModel> listCartModel) async {
    final hiveListCartModel = listCartModel
        .map(
          (e) => CartHiveModel(
            name: e.name,
            weight: e.weight,
            price: e.price,
            image: e.image,
            indexEl: e.indexEl,
            wholePack: e.wholePack,
          ),
        )
        .toList();

    await _cartStorage.saveCart(hiveListCartModel);
  }

  Future<List<CartHiveModel>> getCart() async {
    final cart = await _cartStorage.getCart();

    return cart;
  }

  Future<void> addItemToCart(CartHiveModel cartHiveModel) async {
    final cart = await _cartStorage.getCart();

    cart.add(cartHiveModel);

    await _cartStorage.saveCart(cart);
  }

  Future<void> addCartToBackend(int userId) async {
    final cart = await _cartStorage.getCart();

    final nCart = cart
        .map(
          (e) => CartModelResponse(
            name: e.name,
            weight: e.weight,
            price: e.price,
            image: e.image,
            indexEl: e.indexEl,
            wholePack: e.wholePack,
          ),
        )
        .toList();

    await _cartApi.addCart(userId, nCart);
  }

  Future<void> clearCartInStorage() async {
    await _cartStorage.clearCart();
  }

  Future<void> clearCartOnBackend(int userId) async {
    await _cartStorage.clearCart();
    await _cartApi.addCart(userId, []);
  }

  Future<void> saveCartLength(int cartLength) async {
    await _cartStorage.saveCartLength(cartLength);
  }

  Future<int> getCartLength() async {
    final length = await _cartStorage.getCartLength();

    return length ?? 0;
  }
}
