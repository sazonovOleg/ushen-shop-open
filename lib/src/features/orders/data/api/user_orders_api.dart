import 'dart:convert';

import 'package:TeaShopApp/src/features/orders/data/api/user_orders_constants.dart';
import 'package:TeaShopApp/src/features/orders/data/models/resp/user_orders_resp_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserOrdersApi {
  final Dio _dio;

  UserOrdersApi(this._dio);

  Future<List<UserOrdersModelResponse>> getOrders(int userId) async {
    final response = await _dio.post(
      UserOrdersApiConstants.findOrderApi,
      data: {
        'userId': userId,
      },
    );

    if (response.data.toString() == 'Список заказов пуст') {
      return [];
    } else {
      return userOrdersResponseFromJson(response.data);
    }
  }

  Future<void> createOrder(UserOrdersModelResponse modelResponse) async {
    final goodsResponse =
        json.decode(orderGoodsResponseToJson(modelResponse.goods));

    await _dio.post(
      UserOrdersApiConstants.createOrderApi,
      data: {
        'userId': modelResponse.userId,
        'date': modelResponse.date,
        'goods': goodsResponse,
        'delivery': modelResponse.delivery,
        'userName': modelResponse.userName,
        'address': modelResponse.address,
        'postcode': modelResponse.postcode,
        'commentForOrder': modelResponse.commentForOrder,
        'totalSum': modelResponse.totalSum,
        'totalCount': modelResponse.totalCount,
        'status': modelResponse.status,
        'received': modelResponse.received,
      },
    );
  }
}
