import 'package:flutter/foundation.dart';
import '../model/user_model.dart';

class RegistrationViewModel extends ChangeNotifier {
  String? username;
  String? email;
  String? password;

  bool _isRegistrationLoading = false;
  bool get isRegistrationLoading => _isRegistrationLoading;

  void registerUser() async {
    if (_isRegistrationLoading) return;

    _isRegistrationLoading = true;
    notifyListeners();

    // Simulating an asynchronous registration process
    await Future.delayed(const Duration(seconds: 2));

    // Perform actual registration logic here
    // You can call an API or interact with your data services

    _isRegistrationLoading = false;
    notifyListeners();
  }

  bool validateFields() {
    return username != null && email != null && password != null;
  }
}
