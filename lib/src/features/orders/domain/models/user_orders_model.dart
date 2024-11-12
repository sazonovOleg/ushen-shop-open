class UserOrdersModel {
  UserOrdersModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.goods,
    required this.totalSum,
    required this.status,
  });

  final int id;
  final int userId;
  final String date;
  final List<OrdersGoods> goods;
  final String totalSum;
  final String status;
}

class OrdersGoods {
  OrdersGoods({
    required this.name,
    required this.weight,
    required this.price,
  });

  final String name;
  final String weight;
  final String price;
}

class UserOrdersModelForResponse {
  UserOrdersModelForResponse({
    required this.delivery,
    required this.userName,
    required this.address,
    required this.postcode,
    required this.commentForOrder,
  });

  final String delivery;
  final String userName;
  final String address;
  final String postcode;
  final String commentForOrder;
}