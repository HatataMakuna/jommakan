import 'package:jom_makan/pages/FoodDelivery/controllers/authen_controller.dart';
import 'package:jom_makan/pages/FoodDelivery/routes/links.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final RxBool _loading = true.obs;
  final AuthenController authenController = Get.find<AuthenController>();

  get loading => _loading.value;

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    _updateLoading(false);
    super.onInit();
  }

  void goToHome() async {
    _updateLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    await authenController.doSetToken("FAKE_TOKEN");
    Get.toNamed(AppLinks.HOME_NAVIGATION);
    _updateLoading(false);
  }

  void _updateLoading(bool _value) {
    _loading(_value);
    update();
  }
}
