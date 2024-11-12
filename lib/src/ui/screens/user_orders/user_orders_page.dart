import 'package:TeaShopApp/src/features/orders/domain/models/user_orders_model.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/screens/user_orders/user_orders_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrdersPage extends StatefulWidget {
  const UserOrdersPage({Key? key}) : super(key: key);

  @override
  State<UserOrdersPage> createState() => _WidgetState();
}

class _WidgetState extends State<UserOrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserOrdersPageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserOrdersPageVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 15,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Заказы',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            vm.isLoading
                ? const LottieLoading()
                : SizedBox(
                    width: double.infinity,
                    child: vm.ordersList.isNotEmpty
                        ? Column(
                            children: vm.ordersList
                                .map(
                                  (e) => _OrderItem(
                                    date: e.date,
                                    orderId: e.id.toString(),
                                    goods: e.goods,
                                    totalSum: e.totalSum,
                                    status: vm.translateStatus(e.status),
                                    statusColor: vm.setStatusColor(e.status),
                                  ),
                                )
                                .toList(),
                          )
                        : Column(
                            children: [
                              Text(
                                'Список заказов пуст.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 17),
                              ),
                              const LottieEmpty()
                            ],
                          ),
                  )
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String date;
  final String orderId;
  final List<OrdersGoods> goods;
  final String totalSum;
  final String status;
  final MaterialColor statusColor;

  const _OrderItem({
    required this.date,
    required this.orderId,
    required this.goods,
    required this.totalSum,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 15,),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(
                10,
              ),
              width: double.infinity,
              color: const Color(0xDEDADADA),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Заказ от ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: date,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '№ ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: orderId,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Text(
                      'Товары в заказе: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: goods
                        .asMap()
                        .entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: RichText(
                              text: TextSpan(
                                text: '${(e.key + 1).toString()}. ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                children: [
                                  TextSpan(
                                    text: '${e.value.name} ,',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(height: 1.1),
                                  ),
                                  TextSpan(
                                    text: 'вес-${e.value.weight} гр. ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.1,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'сумма-${e.value.price} ₽.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.1,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Общая сумма: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: '$totalSum₽',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Статус: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: status,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: statusColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
