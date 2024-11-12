import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/screens/profile_info/profile_info_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoPage> createState() => _WidgetState();
}

class _WidgetState extends State<ProfileInfoPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileInfoVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileInfoVM>(context);

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: vm.isLoading
            ? const LottieLoading()
            : Column(
                children: [
                  vm.nameTextField
                      ? _ChangeCard(
                          controller: vm.nameController,
                          save: vm.saveName,
                          cancel: vm.cancelName,
                          onChanged: vm.validateName,
                          isVerify: vm.isValidateName,
                        )
                      : _InfoCard(
                          firstText: vm.profileHiveModel.name,
                          secondText: 'Изменить имя',
                          icon: Icons.arrow_forward_ios_sharp,
                          onTap: vm.changeName,
                        ),
                  vm.lastNameTextField
                      ? _ChangeCard(
                          controller: vm.lastNameController,
                          save: vm.saveLastName,
                          cancel: vm.cancelLastName,
                          onChanged: vm.validateLastName,
                          isVerify: vm.isValidateLastName,
                        )
                      : _InfoCard(
                          firstText: vm.profileHiveModel.lastName,
                          secondText: 'Изменить фамилию',
                          icon: Icons.arrow_forward_ios_sharp,
                          onTap: vm.changeLastName,
                        ),
                  vm.phoneTextField
                      ? _ChangeCard(
                          controller: vm.phoneController,
                          save: vm.savePhone,
                          cancel: vm.cancelPhone,
                          onChanged: vm.validatePhone,
                          isVerify: vm.isValidatePhone,
                        )
                      : _InfoCard(
                          firstText: vm.profileHiveModel.phone,
                          secondText: Strings.changePhone,
                          icon: Icons.arrow_forward_ios_sharp,
                          onTap: vm.changePhone,
                        ),
                  vm.emailTextField
                      ? _ChangeCard(
                          controller: vm.emailController,
                          save: vm.saveEmail,
                          cancel: vm.cancelEmail,
                          onChanged: vm.validateEmail,
                          isVerify: vm.isValidateEmail,
                        )
                      : _InfoCard(
                          firstText: vm.profileHiveModel.email,
                          secondText: Strings.changeEmail,
                          icon: Icons.arrow_forward_ios_sharp,
                          onTap: vm.changeEmail,
                        ),
                  _InfoCard(
                    firstText: '${vm.profileHiveModel.discount}%',
                    secondText: Strings.yourDiscount,
                    icon: Icons.percent,
                  ),
                  _InfoCard(
                    firstText: '${vm.profileHiveModel.totalPurchaseAmount}₽',
                    secondText: Strings.totalPurchaseSum,
                    icon: Icons.currency_ruble,
                  ),
                  AppBtn(
                    btnText: 'Выйти',
                    iconPath: 'images/profile/login.svg',
                    onTap: () => vm.logout(),
                    disabled: false,
                  ),
                ],
              ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String firstText;
  final String secondText;
  final IconData icon;
  final void Function()? onTap;

  const _InfoCard({
    required this.firstText,
    required this.secondText,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: .5,
            color: const Color(0xFFCCCCCC),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstText,
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  secondText,
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Icon(
              icon,
              size: 30,
              color: const Color(0xFF5D5D5D),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeCard extends StatelessWidget {
  final TextEditingController controller;
  final void Function() save;
  final void Function() cancel;
  final void Function(String) onChanged;
  final bool isVerify;

  const _ChangeCard({
    required this.controller,
    required this.save,
    required this.cancel,
    required this.onChanged,
    required this.isVerify,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: .5,
          color: const Color(0xFFCCCCCC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            cursorWidth: 1,
            onChanged: onChanged,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF4E4A4B),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                child: TextButton(
                  onPressed: isVerify ? save : null,
                  style: ButtonStyle(
                    backgroundColor: isVerify
                        ? WidgetStateProperty.all(const Color(0xFF89FF5E))
                        : WidgetStateProperty.all(const Color(0x32FCFCFC)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Сохранить',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                child: TextButton(
                  onPressed: cancel,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    Strings.cancel,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
