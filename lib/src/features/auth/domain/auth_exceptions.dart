class IncorrectPassword extends AuthException {
  IncorrectPassword()
      : super('Введен неверный пароль');
}

class UserNotFound extends AuthException {
  UserNotFound()
      : super('Пользователь не найден');
}

class UserIsAlready extends AuthException {
  UserIsAlready()
      : super('Пользователь с данной почтой уже зарегестрирован');
}

class IncorrectToken extends AuthException {
  IncorrectToken()
      : super('Неправильный код верификации');
}

class IncorrectEmailForResetPass extends AuthException {
  IncorrectEmailForResetPass()
      : super('Пользователя с такой почтой не существует');
}

class AuthException implements Exception {
  String errorMessage;

  AuthException(this.errorMessage) : super();
}
