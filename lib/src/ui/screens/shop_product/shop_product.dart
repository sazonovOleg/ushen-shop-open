import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/screens/shop_product/shop_product_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShopProductPage extends StatefulWidget {
  final int teaId;

  const ShopProductPage({
    super.key,
    required this.teaId,
  });

  @override
  State<ShopProductPage> createState() => _WidgetState();
}

class _WidgetState extends State<ShopProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShopProductPageVM>().init(widget.teaId);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ShopProductPageVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: true,
      ),
      body: vm.isLoading
          ? const LottieLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text(
                          vm.teaModel.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      )),
                  _Slider(
                    vm: vm,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _TabsBar(
                      vm: vm,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _Slider extends StatelessWidget {
  final ShopProductPageVM vm;

  const _Slider({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: vm.sliderOptions,
      items: vm.teaModel.images.map(
        (image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Center(
                      child: Image(
                        image: AssetImage(
                          'assets/images/nophoto.png',
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}

class _TabsBar extends StatelessWidget {
  final ShopProductPageVM vm;

  const _TabsBar({required this.vm});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            onTap: (index) => vm.selectTabBar(index),
            tabs: [
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: SvgPicture.asset(
                    'assets/images/shop/add_basket.svg',
                    width: 45,
                    height: 45,
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: SvgPicture.asset(
                    'assets/images/shop/info.svg',
                    width: 45,
                    height: 45,
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: SvgPicture.asset(
                    'assets/images/shop/teapot.svg',
                    width: 45,
                    height: 45,
                  ),
                ),
              ),
            ],
          ),
          Builder(
            builder: (_) {
              switch (vm.selectedTabBar) {
                case 0:
                  return _TeaCard(vm: vm);
                case 1:
                  return _DescriptionText(
                    title: 'Немного о чае.',
                    descriptionText: vm.teaModel.description.first,
                  );
                case 2:
                  return _DescriptionText(
                    title: 'Как заваривать?',
                    descriptionText: vm.teaModel.description.last,
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String title;
  final String descriptionText;

  const _DescriptionText({
    required this.title,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            descriptionText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}

class _TeaCard extends StatelessWidget {
  final ShopProductPageVM vm;

  const _TeaCard({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: !vm.isAnimation
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: .8, color: Color(0xFFE1E1E1)),
                      ),
                    ),
                    child: Text(
                      vm.teaModel.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  vm.teaInStock()
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          margin: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: .8, color: Color(0xFFE1E1E1)),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: '${vm.setPrice()}₽ ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                vm.teaModel.saleQuantity == 5
                                    ? const TextSpan(
                                        text: '(цена указана за 5 шт.)',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      )
                                    : TextSpan(
                                        text: vm.teaModel.full
                                            ? '(цена указана за целый блин)'
                                            : '(цена указана за ${vm.weightListItem} гр)',
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: .8, color: Color(0xFFE1E1E1)),
                      ),
                    ),
                    child: vm.teaInStock()
                        ? const Text(
                            'В наличии',
                            style: TextStyle(
                              color: Color(0xFF00AB24),
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            'Товар временно отсутствует',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 16,
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: vm.teaModel.full
                        ? const SizedBox()
                        : vm.teaModel.price != 0
                            ? Row(
                                children: vm.weightList.map(
                                  (e) {
                                    return _CheckBox(
                                      weight: e,
                                      vm: vm,
                                    );
                                  },
                                ).toList(),
                              )
                            : const SizedBox(),
                  ),
                  vm.teaInStock()
                      ? AppBtn(
                          btnText: 'Добавить в коризну',
                          iconPath: 'assets/images/shop/add_basket.svg',
                          onTap: () => vm.addToCart(),
                          disabled: false,
                        )
                      : const SizedBox(),
                ],
              )
            : const LottieCartAdded(),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  final int weight;
  final ShopProductPageVM vm;

  const _CheckBox({
    required this.weight,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          weight.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Transform.scale(
          scale: 1.2,
          child: Checkbox(
            activeColor: const Color(0xFF4E4A4B),
            value: vm.isChecked(weight),
            visualDensity:
                const VisualDensity(horizontal: -3.0, vertical: -3.0),
            onChanged: (value) => vm.setCheckBox(value!, weight),
          ),
        )
      ],
    );
  }
}
