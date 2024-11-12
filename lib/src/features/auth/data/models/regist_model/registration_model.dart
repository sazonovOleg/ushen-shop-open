class RegistrationModel {
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  RegistrationModel({
    required this.name,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  });

  RegistrationModel.empty()
      : name = '',
        lastName = '',
        phone = '',
        email = '',
        password = '';
}
