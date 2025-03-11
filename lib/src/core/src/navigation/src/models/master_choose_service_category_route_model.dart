import 'package:flutter/material.dart';

@immutable
class MasterChooseServiceCategoryRouteModel {
  final int serviceId;
  final int genderId;
  final String serviceName;

  const MasterChooseServiceCategoryRouteModel({
    required this.serviceId,
    required this.genderId,
    required this.serviceName,
  });
}
