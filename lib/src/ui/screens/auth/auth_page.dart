import 'package:TeaShopApp/src/constants/strings_global.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/app_btn.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/lottie_anim.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/pass_field.dart';
import 'package:TeaShopApp/src/ui/common/ui_components/text_field.dart';
import 'package:TeaShopApp/src/ui/screens/auth/auth_page_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _WidgetState();
}

class _WidgetState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthPageVM>().init();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthPageVM>(context);

    return SingleChildScrollView(
      child: vm.isLoading
          ? const Center(
              child: LottieLoading(),
            )
          : Column(
              children: [
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (index) => vm.selectTabBar(index),
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Text(
                              Strings.login,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Tab(
                            child: Text(
                              Strings.registration,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) {
                          switch (vm.selectedTabBar) {
                            case 0:
                              return _LoginTab(
                                vm: vm,
                              );
                            case 1:
                              return _RegistrationTab(
                                vm: vm,
                              );
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _LoginTab extends StatelessWidget {
  final AuthPageVM vm;

  const _LoginTab({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldComp(
            infoText: Strings.email,
            controller: vm.emailController,
            isVerify: vm.isValidateEmail,
            onChanged: vm.validateEmail,
          ),
          PasswordField(
            infoText: Strings.password,
            controller: vm.passController,
            isVerify: vm.isValidatePass,
            onChanged: vm.validatePass,
          ),
          InkWell(
            onTap: () => vm.goToRecoveryPassPage(context),
            child: const Text(
              Strings.forgotPass,
              style: TextStyle(
                color: Color(0xFF2954FF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AppBtn(
            btnText: Strings.login,
            iconPath: 'assets/images/profile/login.svg',
            onTap: () => vm.login(context),
            disabled: vm.disabledLoginBtn(),
          ),
        ],
      ),
    );
  }
}

class _RegistrationTab extends StatelessWidget {
  final AuthPageVM vm;

  const _RegistrationTab({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Column(
        children: [
          TextFieldComp(
            infoText: Strings.name,
            controller: vm.nameController,
            isVerify: vm.isValidateName,
            onChanged: vm.validateName,
          ),
          TextFieldComp(
            infoText: Strings.surname,
            controller: vm.lastNameController,
            isVerify: vm.isValidateLastName,
            onChanged: vm.validateLastName,
          ),
          TextFieldComp(
            infoText: Strings.phoneNumber,
            controller: vm.phoneController,
            isVerify: vm.isValidatePhone,
            onChanged: vm.validatePhone,
          ),
          TextFieldComp(
            infoText: Strings.email,
            controller: vm.emailController,
            isVerify: vm.isValidateEmail,
            onChanged: vm.validateEmail,
          ),
          PasswordField(
            infoText: Strings.password,
            controller: vm.passController,
            isVerify: vm.isValidatePass,
            onChanged: vm.validatePass,
          ),
          PasswordField(
            infoText: Strings.confirmPassword,
            controller: vm.confirmPassController,
            isVerify: vm.isValidateConfirmPass,
            onChanged: vm.validateConfirmPass,
          ),
          const SizedBox(
            height: 15,
          ),
          AppBtn(
            btnText: Strings.register,
            iconPath: 'assets/images/profile/user_add.svg',
            onTap: () => vm.registration(context),
            disabled: vm.disabledRegBtn(),
          ),
        ],
      ),
    );
  }
}
