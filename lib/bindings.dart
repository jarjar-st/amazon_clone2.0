import 'package:amazon_clone/providers/user_provider_getx.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
  }
}
