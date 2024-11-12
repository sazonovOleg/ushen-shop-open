import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_bar.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/text_field.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileVerificationPage extends StatefulWidget {
  const ProfileVerificationPage({Key? key}) : super(key: key);

  @override
  State<ProfileVerificationPage> createState() => _WidgetState();
}

class _WidgetState extends State<ProfileVerificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileVerificationVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileVerificationVM>(context);

    return Scaffold(
      appBar: const AppBarComponent(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  Strings.verifyProfile,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              TextFieldComp(
                infoText: Strings.enterCode,
                controller: vm.verifyController,
                isVerify: vm.isVerify,
                onChanged: vm.validateVerify,
              ),
              AppBtn(
                btnText: Strings.send,
                iconPath: 'images/profile/send.svg',
                onTap: () => vm.sendToken(context),
                disabled: !vm.isVerify,
              )
            ],
          ),
        )
      ),
    );
  }
}
