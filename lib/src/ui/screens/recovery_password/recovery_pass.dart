import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/text_field.dart';
import 'package:TeaShopApp/src/ui/screens/recovery_password/recovery_pass_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoveryPassPage extends StatefulWidget {
  const RecoveryPassPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPassPage> createState() => _WidgetState();
}

class _WidgetState extends State<RecoveryPassPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecoveryPassVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RecoveryPassVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              Strings.recoverPass,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Column(
              children: [
                TextFieldComp(
                  infoText: Strings.enterEmail,
                  controller: vm.emailController,
                  isVerify: vm.isValidateEmail,
                  onChanged: vm.validateEmail,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppBtn(
                  btnText: Strings.resetPass,
                  iconPath: 'images/profile/reset_pass.svg',
                  onTap: () => vm.resetPass(),
                  disabled: !vm.isValidateEmail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
