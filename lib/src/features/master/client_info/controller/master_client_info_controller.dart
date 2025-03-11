import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

class MasterClientInfoController extends BaseController<void> {
  final _repository = GetIt.instance<MasterClientsRepository>();

  Future<void> deleteClient(MasterClientDto data) async {
    await deleteData(() => _repository.deleteClient(data: data));
  }
}
