import 'package:TeaShopApp/src/features/auth/domain/auth_bus.dart';
import 'package:TeaShopApp/src/features/auth/domain/auth_service.dart';
import 'package:TeaShopApp/src/features/profile/domain/models/profile_hive_model.dart';
import 'package:TeaShopApp/src/features/profile/domain/profile_service.dart';
import 'package:TeaShopApp/src/ui/common/error_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ProfileInfoVM extends ChangeNotifier with ErrorHandler {
  final ProfileService _profileService;
  final AuthService _authService;
  final AuthBus _authBus;

  ProfileHiveModel profileHiveModel = ProfileHiveModel.empty();

  ProfileInfoVM(
    this._profileService,
    this._authService,
    this._authBus,
  );

  ///TODO rename variables
  bool isLoading = true;
  bool nameTextField = false;
  bool lastNameTextField = false;
  bool phoneTextField = false;
  bool emailTextField = false;
  bool isValidateName = false;
  bool isValidateLastName = false;
  bool isValidatePhone = false;
  bool isValidateEmail = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> init() async {
    try {
      await _profileService
          .getProfile()
          .then((value) => value.isVerified ? profileHiveModel = value : null);
    } on Exception catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      handleError(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void changeName() {
    nameTextField = true;
    notifyListeners();
  }

  Future<void> saveName() async {
    await changeProfileData('name', nameController.text);
  }

  void cancelName() {
    nameTextField = false;
    notifyListeners();
  }

  void validateName(String value) {
    value.length > 2 ? isValidateName = true : isValidateName = false;

    notifyListeners();
  }

  void changeLastName() {
    lastNameTextField = true;
    notifyListeners();
  }

  Future<void> saveLastName() async {
    await changeProfileData('lastName', lastNameController.text);
  }

  void cancelLastName() {
    lastNameTextField = false;
    notifyListeners();
  }

  void validateLastName(String value) {
    if (value.length > 3) {
      isValidateLastName = true;
    } else {
      isValidateLastName = false;
    }

    notifyListeners();
  }

  void changePhone() {
    phoneTextField = true;
    notifyListeners();
  }

  Future<void> savePhone() async {
    await changeProfileData('phone', phoneController.text);
  }

  void cancelPhone() {
    phoneTextField = false;
    notifyListeners();
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

  void changeEmail() {
    emailTextField = true;
    notifyListeners();
  }

  Future<void> saveEmail() async {
    await changeProfileData('email', emailController.text);
  }

  void cancelEmail() {
    emailTextField = false;
    notifyListeners();
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

  Future<void> changeProfileData(String type, String value) async {
    isLoading = true;
    notifyListeners();

    await _profileService.changeProfileData(type, value);

    await _profileService
        .getProfile()
        .then((value) => value.name.isNotEmpty ? profileHiveModel = value : null);

    reloadState();

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout().then((value) async => await _authBus.clearStorageAfterLogout());

    notifyListeners();
  }

  void reloadState() async {
    nameTextField = false;
    lastNameTextField = false;
    phoneTextField = false;
    emailTextField = false;
    isValidateName = false;
    isValidateLastName = false;
    isValidatePhone = false;
    isValidateEmail = false;
    nameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    notifyListeners();
  }
}
