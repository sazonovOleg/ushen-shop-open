import 'package:TeaShopApp/src/ui/common/ui_components/loading_page.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/screens/shop/shop_page_vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  final String teaType;
  final String teaSubtype;

  const ShopPage({
    super.key,
    required this.teaType,
    required this.teaSubtype,
  });

  @override
  State<ShopPage> createState() => _WidgetState();
}

class _WidgetState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShopPageVM>().init(context, widget.teaType, widget.teaSubtype);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ShopPageVM>(context);

    return Scaffold(
      appBar: AppBar(
        leading: vm.isBackBtn
            ? BackButton(onPressed: () => vm.onBackPressed(context))
            : const SizedBox(),
        centerTitle: true,
        title: const Image(
          image: AssetImage('images/logo.png'),
          width: 140,
          height: 28,
        ),
        backgroundColor: const Color(0xFF4C4C4D),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Чай',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              child: vm.isLoading
                  ? const LottieLoading()
                  : _ProductList(
                      vm: vm,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  final ShopPageVM vm;

  const _ProductList({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: vm.teaList.isNotEmpty
          ? vm.teaList
              .map(
                (e) => _ProductListItem(
                  vm: vm,
                  name: e.name,
                  imgUrl: e.images[0],
                  type: e.type,
                  subtype: e.subtype,
                  price: e.price,
                  fullPrice: e.fullPrice,
                  full: e.full,
                  goToPage: () => vm.goToShopProductPage(context, e.id),
                ),
              )
              .toList()
          : vm.allTeaList
              .map(
                (e) => _ProductListItem(
                  vm: vm,
                  name: e.name,
                  imgUrl: e.img,
                  type: e.type,
                  subtype: e.subtype,
                  goToPage: () => vm.goToPage(
                    context,
                    e.type,
                    e.subtype,
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _ProductListItem extends StatelessWidget {
  final ShopPageVM vm;
  final String name;
  final String imgUrl;
  final String type;
  final String subtype;
  final double? price;
  final double? fullPrice;
  final bool? full;
  final void Function() goToPage;

  const _ProductListItem({
    required this.vm,
    required this.name,
    required this.imgUrl,
    required this.type,
    required this.subtype,
    required this.goToPage,
    this.price,
    this.fullPrice,
    this.full,
  });

  @override
  Widget build(BuildContext context) {
    double itemWidth = ((MediaQuery.of(context).size.width - 35) / 2);

    return Container(
      constraints: BoxConstraints(maxWidth: itemWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: .5,
          color: const Color(0xFFCCCCCC),
        ),
      ),
      child: InkWell(
        onTap: goToPage,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                errorWidget: (context, url, error) => const Center(
                  child: Image(
                    image: AssetImage(
                      'images/nophoto.png',
                    ),
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              constraints: const BoxConstraints(minHeight: 45),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            price != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                    ),
                    child: full!
                        ? RichText(
                            text: fullPrice! != 0
                                ? TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            '${fullPrice!.toStringAsFixed(0)}₽',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const TextSpan(
                                        text: ' за ',
                                        children: [
                                          TextSpan(
                                            text: '1 шт.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : TextSpan(
                                    text: 'Товар отсутсвует',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.red,
                                        ),
                                  ),
                          )
                        : RichText(
                            text: price != 0
                                ? TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            '${(price! * 25).toStringAsFixed(0)}₽',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const TextSpan(
                                        text: ' за ',
                                        children: [
                                          TextSpan(
                                            text: '25гр.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : TextSpan(
                                    text: 'Товар отсутсвует',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.red,
                                        ),
                                  ),
                          ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
