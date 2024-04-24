import 'package:aldlal/core/viewModel/auth_viewmodel.dart';
import 'package:aldlal/core/viewModel/controle_viewmodel.dart';
import 'package:aldlal/core/viewModel/home_viewmodel.dart';
import 'package:aldlal/core/viewModel/profile_viewmodel.dart';
import 'package:aldlal/core/viewModel/splash_screen_viewmodel.dart';
import 'package:aldlal/core/viewModel/verification_viewmodel.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(), fenix: true);
    Get.lazyPut(() => SplashScreenViewModel());
    Get.lazyPut(() => VerificationViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel());
  }
}
