import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/features/cart/domain/models/cart_model.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/screens/cart/cart_page_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _WidgetState();
}

class _WidgetState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartPageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CartPageVM>(context);

    if (!vm.startInitCart) {
      vm.init();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Image(
          image: AssetImage('images/logo.png'),
          width: 140,
          height: 28,
        ),
        backgroundColor: const Color(0xFF4C4C4D),
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
                  Strings.cart,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            !vm.isAnimation
                ? Container(
                    child: vm.isLoading
                        ? const LottieLoading()
                        : SizedBox(
                            child: vm.cartList.isNotEmpty
                                ? Column(
                                    children: [
                                      _CartBox(
                                        vm: vm,
                                      ),
                                      Column(
                                        children: vm.cartList
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => _CartItem(
                                                item: e.value,
                                                removeItem: () => vm.removeItem(e.key),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      if (vm.cartList.length > 4)
                                        const SizedBox(
                                          height: 100,
                                        )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        Strings.cartEmpty,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(fontSize: 17),
                                      ),
                                      const LottieEmpty()
                                    ],
                                  ),
                          ),
                  )
                : const LottieClearDone()
          ],
        ),
      ),
      bottomSheet: vm.cartList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: SizedBox(
                child: vm.isLogin
                    ? AppBtn(
                        btnText: Strings.placeAnOrder,
                        iconPath: 'images/cart/done.svg',
                        onTap: () => vm.goToOrder(context),
                        disabled: false,
                      )
                    : AppBtn(
                        btnText: Strings.authorization,
                        iconPath: 'images/profile/login.svg',
                        onTap: () => vm.goToProfile(context),
                        disabled: false,
                      ),
              ),
            )
          : const SizedBox(),
    );
  }
}

class _CartBox extends StatelessWidget {
  final CartPageVM vm;

  const _CartBox({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'Товаров ',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '${vm.cartList.length} шт. ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const TextSpan(
                  text: 'на сумму ',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: '${vm.sum} ₽',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 20,
            ),
            child: AppBtn(
              btnText: Strings.clearCart,
              iconPath: 'images/cart/clear_cart.svg',
              onTap: () => vm.clearCart(),
              disabled: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final CartModel item;
  final void Function() removeItem;

  const _CartItem({
    required this.item,
    required this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 15,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: .5,
          color: const Color(0xFFCCCCCC),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: 75,
            imageUrl: item.image,
            errorWidget: (context, url, error) => const Center(
              child: Image(
                image: AssetImage(
                  'images/nophoto.png',
                ),
                width: 30,
                height: 30,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 210,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 4,
                  ),
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Вес: ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: '${item.weight}гр.',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Цена: ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: '${item.price}₽.',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: removeItem,
            child: Container(
              alignment: Alignment.center,
              width: 80,
              height: 80,
              child: SvgPicture.asset(
                'images/cart/remove.svg',
                width: 38,
                height: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
