import 'package:TeaShopApp/src/features/auth/data/models/login_model/login_model.dart';
import 'package:TeaShopApp/src/features/auth/data/models/regist_model/registration_model.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_exceptions.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:TeaShopApp/src/ui/screens/profile_verification/profile_verification_route.dart';
import 'package:TeaShopApp/src/ui/screens/recovery_password/recovery_pass_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPageVM extends ChangeNotifier with ErrorHandler {
  final AuthService _authService;
  final AuthBus _authBus;

  AuthPageVM(
    this._authService,
    this._authBus,
  );

  LoginModel _loginModel = LoginModel.empty();
  RegistrationModel _registrationModel = RegistrationModel.empty();
  int selectedTabBar = 0;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isValidateName = false;
  bool isValidateLastName = false;
  bool isValidatePhone = false;
  bool isValidateEmail = false;
  bool isValidatePass = false;
  bool isValidateConfirmPass = false;

  void init() {}

  void selectTabBar(int index) {
    selectedTabBar = index;
    clearControllers();
    clearValidateValues();

    notifyListeners();
  }

  void goToRecoveryPassPage(BuildContext context) {
    context.pushNamed(RecoveryPassRoute.pageName);
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      _createLoginModel();
      await _login(context);

      isLoading = false;
      notifyListeners();
    } on DioError catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.message);

      isLoading = false;
      notifyListeners();
    }
  }

  void _createLoginModel() {
    _loginModel = LoginModel(
      email: emailController.text,
      password: passController.text,
    );
  }

  Future<void> _login(BuildContext context) async {
    if (_loginModel.email.isEmpty) return;

    await _authService
        .login(_loginModel)
        .then((isLogin) async => await _initProfileAfterLogin(context, isLogin));
  }

  Future<void> _initProfileAfterLogin(BuildContext context, bool isLogin) async {
    if (!isLogin) return;

    await _authBus.initProfileAfterLogin(
      context,
      _loginModel.email,
    );
  }

  void _createRegistrationModel() {
    _registrationModel = RegistrationModel(
      name: nameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passController.text,
    );
  }

  Future<void> registration(BuildContext context) async {
    isLoading = true;

    try {
      _createRegistrationModel();
      await _registration(context);

      clearValidateValues();
      clearControllers();
      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      if (e.toString().contains('409')) {
        handleError(UserIsAlready().errorMessage);
      }

      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _registration(BuildContext context) async {
    if (_registrationModel.email.isEmpty) return;

    await _authService
        .registration(_registrationModel)
        .then((token) => _pushToVerifyRoute(context, token));
  }

  Future<void> _pushToVerifyRoute(BuildContext context, String token) async {
    if (token.isEmpty) return;

    await context.pushNamed(ProfileVerificationRoute.pageName);
  }

  void clearControllers() {
    nameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
  }

  void clearValidateValues() {
    isValidateName = false;
    isValidateLastName = false;
    isValidatePhone = false;
    isValidateEmail = false;
    isValidatePass = false;
    isValidateConfirmPass = false;
  }

  void validateName(String value) {
    if (value.length > 2) {
      isValidateName = true;
      notifyListeners();
    } else {
      isValidateName = false;
      notifyListeners();
    }
  }

  void validateLastName(String value) {
    ///TODO проверить notify
    if (value.length > 2) {
      isValidateLastName = true;
      notifyListeners();
    } else {
      isValidateLastName = false;
      notifyListeners();
    }
  }

  void validatePhone(String value) {
    bool isPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);

    if (value.startsWith('+') && isPhone && value.length == 12) {
      isValidatePhone = true;
      notifyListeners();
    } else if (value.startsWith('8') && isPhone && value.length == 11) {
      isValidatePhone = true;
      notifyListeners();
    } else {
      isValidatePhone = false;
      notifyListeners();
    }
  }

  void validateEmail(String value) {
    bool isEmail = RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(value);

    if (isEmail) {
      isValidateEmail = true;
      notifyListeners();
    } else {
      isValidateEmail = false;
      notifyListeners();
    }
  }

  void validatePass(String value) {
    if (value.length > 6) {
      isValidatePass = true;
      notifyListeners();
    } else {
      isValidatePass = false;
      notifyListeners();
    }
  }

  void validateConfirmPass(String value) {
    if (value == passController.text) {
      isValidateConfirmPass = true;
      notifyListeners();
    } else {
      isValidateConfirmPass = false;
      notifyListeners();
    }
  }

  bool disabledLoginBtn() {
    if (isValidateEmail && isValidatePass) {
      return false;
    } else {
      return true;
    }
  }

  bool disabledRegBtn() {
    if (isValidateName &&
        isValidateLastName &&
        isValidateEmail &&
        isValidatePass &&
        isValidatePhone &&
        isValidateConfirmPass) {
      return false;
    } else {
      return true;
    }
  }
}
