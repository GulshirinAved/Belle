// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';

part 'client_personal_info_controller.g.dart';

class ClientPersonalInfoController = _ClientPersonalInfoControllerBase with _$ClientPersonalInfoController;

abstract class _ClientPersonalInfoControllerBase with Store {
  @observable
  int gender = 1;

  @action
  void toggleGender(int value) {
    gender = value;
  }

}