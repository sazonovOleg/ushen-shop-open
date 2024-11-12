class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  LoginModel.empty()
      : email = '',
        password = '';
}
