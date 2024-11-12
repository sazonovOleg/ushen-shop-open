import 'package:TeaShopApp/src/features/cart/data/cart_repo.dart';
import 'package:TeaShopApp/src/features/cart/data/models/hive/cart_hive_model.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:rxdart/rxdart.dart';

class CartService {
  final CartRepo _cartRepo;

  CartService(
    this._cartRepo,
  );

  final _cartGoodsState = BehaviorSubject<int>.seeded(0);

  Stream<int> get cartGoodsState => _cartGoodsState.stream;

  Future<void> saveCart(int userId) async {
    await _cartRepo.saveCart(userId);
    await getCartGoodsLength();
  }

  Future<List<CartModel>> getCart() async {
    final storageCart = await _cartRepo.getCart();

    final cart = storageCart
        .map(
          (e) => CartModel(
            name: e.name,
            weight: e.weight,
            price: e.price,
            image: e.image,
            indexEl: e.indexEl,
            wholePack: e.wholePack,
          ),
        )
        .toList();

    return cart;
  }

  Future<void> reSaveCart(List<CartModel> listCartModel) async {
    _cartGoodsState.value = listCartModel.length;
    await _cartRepo.saveCartLength(listCartModel.length);

    await _cartRepo.reSaveCart(listCartModel);
  }

  Future<void> addItemToCart(CartModel cartModel) async {
    await _cartRepo.addItemToCart(
      CartHiveModel(
        name: cartModel.name,
        weight: cartModel.weight,
        price: cartModel.price,
        image: cartModel.image,
        indexEl: cartModel.indexEl,
        wholePack: cartModel.wholePack,
      ),
    ).then((value) async => {
      await getCartGoodsLength()
    });
  }

  Future<void> addCartToBackend(int userId) async {
    await _cartRepo
        .addCartToBackend(userId)
        .then((value) async => await getCartGoodsLength());
  }

  Future<void> clearCartOnBackend(int userId) async {
    _cartGoodsState.value = 0;

    await _cartRepo.saveCartLength(0);
    await _cartRepo.clearCartOnBackend(userId);
  }

  Future<void> clearCartInStorage() async {
    _cartGoodsState.value = 0;

    await _cartRepo.saveCartLength(0);
    await _cartRepo.clearCartInStorage();
  }

  Future<void> getCartGoodsLength() async {
    final cart = await _cartRepo.getCart();

    _cartGoodsState.value = cart.length;

    await _cartRepo.saveCartLength(cart.length);
  }
}
