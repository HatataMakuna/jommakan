import 'package:jom_makan/pages/FoodDelivery/controllers/authen_controller.dart';
import 'package:jom_makan/pages/FoodDelivery/controllers/welcome_controller.dart';
import 'package:get/get.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
