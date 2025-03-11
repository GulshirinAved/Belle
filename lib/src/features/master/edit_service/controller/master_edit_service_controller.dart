import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';
import '../../master.dart';

part 'master_edit_service_controller.g.dart';

class MasterEditServiceController extends BaseController<MasterEditServiceDto> {
  final _repository = GetIt.instance<MasterEditServiceRepository>();

  Future<void> editService(
      MasterEditServiceDto? data, VoidCallback onSuccess) async {
    await postData(
      () => _repository.editService(data).then((value) {
        onSuccess();
        return value;
      }),
    );
  }

  Future<void> deleteService(int id, VoidCallback onSuccess) async {
    await postData<void>(
      () => _repository.deleteService(id).then((_) {
        onSuccess();
        return _;
      }),
    );
  }
}

class MasterEditServiceStateController = _MasterEditServiceStateControllerBase
    with _$MasterEditServiceStateController;

abstract class _MasterEditServiceStateControllerBase
    with Store, HandlingErrorMixin {
  MasterEditServiceDto? editServiceDto;

  void setupData(MasterServiceDto value) {
    editServiceDto = MasterEditServiceDto.fromMasterServiceDto(value);
    chosenSubservice =
        SubserviceDto(id: value.subserviceId, name: value.subserviceName);
    fixedPriceController.text = (value.fixPrice ?? '').toString();
    minPriceController.text = (value.minPrice ?? '').toString();
    maxPriceController.text = (value.maxPrice ?? '').toString();
    isPriceFixed = value.fixPrice != null;
    commentController.text = value.description ?? '';
    subserviceDuration = value.time! ~/ 30;
  }

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

  MasterEditServiceDto? generateData() {
    try {
      final data = editServiceDto?.copyWith(
        fixPrice: isPriceFixed ? int.tryParse(fixedPriceController.text) : null,
        minPrice: !isPriceFixed ? int.tryParse(minPriceController.text) : null,
        maxPrice: !isPriceFixed ? int.tryParse(maxPriceController.text) : null,
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
