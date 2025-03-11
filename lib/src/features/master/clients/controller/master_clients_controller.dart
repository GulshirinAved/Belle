import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../../client/client.dart';
import '../../master.dart';

class MasterClientsController extends BaseController<MasterClientDto> {
  final _repository = GetIt.instance<MasterClientsRepository>();

  Future<void> fetchClients() async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchClients(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }

  Future<void> fetchMoreClients() async {
    await loadMoreListData(
      ({int? size, int? number}) => _repository.fetchClients(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }
}
