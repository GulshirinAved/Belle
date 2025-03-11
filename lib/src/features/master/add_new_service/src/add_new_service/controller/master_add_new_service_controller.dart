// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:belle/src/utils/utils.dart';
import '../../../../master.dart';

part 'master_add_new_service_controller.g.dart';

class MasterAddNewServiceController extends BaseController<void> {
  final _repository = GetIt.instance<MasterAddNewServiceRepository>();

  Future<void> createNewService(
      MasterAddNewServiceDto data, VoidCallback onSuccess) async {
    await postData(
      () => _repository.createNewService(data).then((value) {
        onSuccess();
        return value;
      }),
    );
  }
}

class MasterAddNewServiceStateController = _MasterAddNewServiceStateControllerBase
    with _$MasterAddNewServiceStateController;

abstract class _MasterAddNewServiceStateControllerBase
    with Store, HandlingErrorMixin {
  @observable
  SubserviceDto? chosenSubservice;

  @observable
  int? subserviceDuration;

  @observable
  bool isPriceFixed = true;

  final fixedPriceController = TextEditingController();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final commentController = TextEditingController();

  MasterAddNewServiceDto generateData() {
    try {
      final data = MasterAddNewServiceDto(
        fixPrice: isPriceFixed ? int.tryParse(fixedPriceController.text) : null,
        minPrice: !isPriceFixed ? int.tryParse(minPriceController.text) : null,
        maxPrice: !isPriceFixed ? int.tryParse(maxPriceController.text) : null,
        idCSubservice: chosenSubservice?.id,
        description: commentController.text,
        time: ((subserviceDuration ?? -1) + 1) * 30,
      );
      return data;
    } catch (e) {
      handleError(e.toString());
      rethrow;
    }
  }

  @action
  void togglePriceFixed(bool value) {
    isPriceFixed = value;
  }

  @action
  void changeChosenSubservice(SubserviceDto? value) {
    chosenSubservice = value;
  }

  @action
  void changeSubserviceDuration(int value) {
    subserviceDuration = value;
  }

  void dispose() {
    fixedPriceController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    commentController.dispose();
  }
}
