import 'package:TeaShopApp/src/features/cart/domain/cart_service.dart';
import 'package:TeaShopApp/src/features/orders/data/models/resp/user_orders_resp_model.dart';
import 'package:TeaShopApp/src/features/orders/data/user_orders_repo.dart';
import 'package:intl/intl.dart';
import 'models/user_orders_model.dart';

class UserOrdersService {
  final UserOrdersRepo _userOrdersRepo;
  final CartService _cartService;

  UserOrdersService(
    this._userOrdersRepo,
    this._cartService,
  );

  Future<void> saveUserOrders(int userId) async {
    await _userOrdersRepo.saveOrders(userId);
  }

  Future<List<UserOrdersModel>> getUserOrders() async {
    final orders = await _userOrdersRepo.getOrders();

    final ordersList = orders
        .map(
          (e) => UserOrdersModel(
            id: e.id,
            userId: e.userId,
            date: e.date,
            goods: e.goods
                .map(
                  (el) => OrdersGoods(
                    name: el.name,
                    weight: el.weight,
                    price: el.price,
                  ),
                )
                .toList(),
            totalSum: e.totalSum,
            status: e.status,
          ),
        )
        .toList();

    return ordersList;
  }

  Future<void> createOrder(
    int userId,
    UserOrdersModelForResponse data,
  ) async {
    final goods = await _cartService.getCart();
    final totalSum = await getTotalSum();
    final totalCount = await getTotalCount();

    await _userOrdersRepo.createOrder(
      UserOrdersModelResponse(
        id: 0,
        userId: userId,
        date: setDate(),
        goods: goods
            .map(
              (e) => OrdersGoodsResponse(
                name: e.name,
                weight: e.weight.toString(),
                price: e.price,
              ),
            )
            .toList(),
        delivery: data.delivery,
        userName: data.userName,
        address: data.address,
        postcode: data.postcode,
        commentForOrder: data.commentForOrder,
        totalSum: totalSum.toString(),
        totalCount: totalCount.toString(),
        status: 'Создан',
        received: false,
      ),
    );
  }

  String setDate() {
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    return date;
  }

  Future<void> clearOrders() async {
    await _userOrdersRepo.clearOrders();
  }

  Future<void> saveTotalSum(int value) async {
    await _userOrdersRepo.saveTotalSum(value);
  }

  Future<int> getTotalSum() async {
    return await _userOrdersRepo.getTotalSum();
  }

  Future<void> saveTotalCount(int value) async {
    await _userOrdersRepo.saveTotalCount(value);
  }

  Future<int?> getTotalCount() async {
    return await _userOrdersRepo.getTotalCount();
  }
}
