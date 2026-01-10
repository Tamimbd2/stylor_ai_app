import 'package:get/get.dart';
import '../controllers/find_similar_controller.dart';

class FindSimilarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindSimilarController>(
      () => FindSimilarController(),
    );
  }
}
