import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final _storage = GetStorage();
  final Rx<User?> user = Rx<User?>(null);
  final RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load from storage
    token.value = _storage.read('token') ?? '';
    final userData = _storage.read('user');
    if (userData != null) {
      user.value = User.fromJson(userData);
    }
  }

  bool get isLoggedIn => token.isNotEmpty;

  void login(String newToken, User newUser) {
    token.value = newToken;
    user.value = newUser;
    _storage.write('token', newToken);
    _storage.write('user', newUser.toJson());
  }

  void logout() {
    token.value = '';
    user.value = null;
    _storage.remove('token');
    _storage.remove('user');
  }

  void updateUser(User updatedUser) {
    user.value = updatedUser;
    _storage.write('user', updatedUser.toJson());
  }

  void updateAvatar(String newAvatarUrl) {
    if (user.value != null) {
      user.value!.avatar = newAvatarUrl;
      user.refresh();
      _storage.write('user', user.value!.toJson());
    }
  }
}
