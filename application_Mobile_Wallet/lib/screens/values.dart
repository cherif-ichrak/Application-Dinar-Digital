import 'package:get/get.dart';

class UserMode extends GetxController {
  RxDouble _solde = 0.0.obs;
  RxString _name = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  get solde => _solde;
  get name => _name;
  set solde(value) => {_solde.value = value, update()};
  decrementSolde(value) {
    _solde.value -= value;
    update();
  }
}
