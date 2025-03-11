import 'package:flutter/foundation.dart';

@immutable
class ClientServiceRouteModel {
  final int? serviceId;
  final String? serviceName;

 const ClientServiceRouteModel(this.serviceId, this.serviceName);
}