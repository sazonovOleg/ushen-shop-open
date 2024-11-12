import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_page_vm.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _WidgetState();
}

class _WidgetState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderPageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<OrderPageVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: vm.isLoading
              ? const LottieLoading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        vm.isOrderCreated ? '' : Strings.placingAnOrder,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    vm.isOrderCreated
                        ? _OrderDone(
                            vm: vm,
                          )
                        : _OrderBox(
                            vm: vm,
                          )
                  ],
                ),
        ),
      ),
    );
  }
}

class _OrderBox extends StatelessWidget {
  final OrderPageVM vm;

  const _OrderBox({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
            ),
            child: Text(
              Strings.deliveryMethod,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Row(
            children: [
              const Text(Strings.postRussia),
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  isError: true,
                  tristate: true,
                  value: true,
                  onChanged: (bool? value) {},
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0x67A2A2A2),
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 8,
            ),
            child: Text(
              Strings.orderInfo,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextFieldComp(
            infoText: Strings.recipientName,
            controller: vm.nameController,
            isVerify: vm.isValidateName,
            onChanged: vm.validateName,
          ),
          TextFieldComp(
            infoText: Strings.recipientAddress,
            controller: vm.addressController,
            isVerify: vm.isValidateAddress,
            onChanged: vm.validateAddress,
          ),
          TextFieldComp(
            infoText: Strings.postCode,
            controller: vm.postcodeController,
            isVerify: vm.isValidatePostcode,
            onChanged: vm.validatePostcode,
          ),
          TextFieldComp(
            infoText: Strings.orderComment,
            controller: vm.commentController,
            isVerify: false,
            maxLines: 4,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Text(
              Strings.fillAllFields,
              style: TextStyle(
                color: Color(0xFFFF0000),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Text(
              Strings.paymentAfterOrder,
              style: TextStyle(
                color: Color(0xFFFF0000),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              '${Strings.orderSum}: ${vm.totalSum}₽.',
            ),
          ),
          AppBtn(
            btnText: Strings.placeAnOrder,
            iconPath: 'images/cart/done.svg',
            onTap: () => vm.createOrder(),
            disabled: vm.disabledBtn(),
          ),
        ],
      ),
    );
  }
}

class _OrderDone extends StatelessWidget {
  final OrderPageVM vm;

  const _OrderDone({
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.orderCreated,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          AppBtn(
            btnText: Strings.returnHome,
            iconPath: 'images/home.svg',
            onTap: () => vm.goToShopPage(context),
            disabled: false,
          ),
        ],
      ),
    );
  }
}
