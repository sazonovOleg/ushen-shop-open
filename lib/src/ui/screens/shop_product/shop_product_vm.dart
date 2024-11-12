import 'package:TeaShopApp/src/features/cart/domain/cart_bus.dart';
import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';
import 'package:TeaShopApp/src/features/tea/domain/tea_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ShopProductPageVM extends ChangeNotifier with ErrorHandler {
  final TeaService _teaService;
  final CartService _cartService;
  final CartBus _cartBus;

  ShopProductPageVM(
    this._teaService,
    this._cartService,
    this._cartBus,
  );

  TeaModel teaModel = TeaModel.empty();

  List<TeaModel> teaList = [];
  List<int> weightList = [25, 50, 100];

  bool isLoading = true;
  bool isAnimation = false;

  int weightListItem = 25;
  int profileId = 0;

  Future<void> init(int id) async {
    try {
      teaList = await _teaService.getSubCategoryTeaList();
      teaModel = teaList.firstWhere((element) => element.id == id);
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }

    _setLoading();
  }

  int selectedTabBar = 0;

  void selectTabBar(int index) {
    selectedTabBar = index;
    notifyListeners();
  }

  final sliderOptions = CarouselOptions(
    height: 340,
    aspectRatio: 4,
    viewportFraction: 0.65,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 5),
    autoPlayAnimationDuration: const Duration(milliseconds: 1000),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    enlargeFactor: 0.3,
    scrollDirection: Axis.horizontal,
  );

  void _setLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  String setPrice() {
    if (teaModel.full) {
      return teaModel.saleQuantity == 5
          ? (teaModel.fullPrice * teaModel.saleQuantity.toInt()).toStringAsFixed(0)
          : teaModel.fullPrice.toStringAsFixed(0);
    } else {
      return (teaModel.price * weightListItem).toStringAsFixed(0);
    }
  }

  bool teaInStock() => int.parse(teaModel.weight) > 50 ? true : false;

  void setCheckBox(bool value, int indexEl) {
    weightListItem = indexEl;
    notifyListeners();
  }

  bool isChecked(int indexEl) => indexEl == weightListItem ? true: false;

  Future<void> startAnimation() async {
    isAnimation = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 1500), () {
      isAnimation = false;
      notifyListeners();
    });
  }

  Future<void> addToCart() async {
    startAnimation();

    await _cartService.addItemToCart(
      CartModel(
        name: teaModel.name,
        weight: weightListItem,
        price: int.parse(setPrice()),
        image: teaModel.images[0],
        indexEl: teaModel.id,
        wholePack: teaModel.full,
      ),
    );

    await _cartBus.addCartToBackend();
  }
}
