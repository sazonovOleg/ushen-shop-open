import 'dart:convert';

import 'package:TeaShopApp/src/features/cart/data/api/cart_api_constants.dart';
import 'package:TeaShopApp/src/features/cart/data/models/resp/cart_resp_model.dart';
import 'package:dio/dio.dart';

class CartApi {
  final Dio _dio;

  CartApi(
    this._dio,
  );

  Future<List<CartModelResponse>> getCart(int userId) async {
    final response = await _dio.post(
      CartApiConstants.getCart,
      data: {
        'userId': userId,
      },
    );

    return cartModelResponseFromJson(response.data['cartData']);
  }

  Future<void> addCart(int userId, List<CartModelResponse> cart) async {
    final cartInfo = json.decode(cartModelResponseToJson(cart));

    await _dio.post(
      CartApiConstants.addCart,
      data: {
        'userId': userId,
        'cartInfo': cartInfo,
      },
    );
  }
}
