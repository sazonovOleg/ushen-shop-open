import 'ui_components/show_message.dart';

mixin ErrorHandler {
  void handleError(String errMessage) {
    AppMessages().showMessage(
      errMessage,
    );
  }
}
