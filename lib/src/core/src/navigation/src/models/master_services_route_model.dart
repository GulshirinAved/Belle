import 'package:flutter/foundation.dart';

@immutable
class MasterServicesRouteModel {
  final int? masterId;
  final List<int?> chosenServices;

  const MasterServicesRouteModel({
    required this.masterId,
    required this.chosenServices,
  });
}
