import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../../shared.dart';

class ReferencesController extends BaseController<ReferencesDto> {
  final _referencesRepository = GetIt.instance<ReferencesRepository>();

  Future<void> fetchReferences() async {
    await fetchData(() => _referencesRepository.fetchReferences());
  }
}

class ReferencesForRegionsController extends BaseController<ReferencesDto> {
  final _referencesRepository = GetIt.instance<ReferencesRepository>();

  Future<void> fetchReferences(int? cityId) async {
    await fetchData(
        () => _referencesRepository.fetchReferences(cityId: cityId));
  }
}
