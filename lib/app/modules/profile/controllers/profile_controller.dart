import 'package:get/get.dart';

class ProfileController extends GetxController {
  final isNotificationEnabled = true.obs;

  void toggleNotification(bool value) {
    isNotificationEnabled.value = value;
  }



}
