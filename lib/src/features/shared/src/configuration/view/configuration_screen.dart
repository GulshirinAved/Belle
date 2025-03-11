import 'package:belle/src/features/shared/src/configuration/controller/configuration_controller.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/widgets/src/spacers/spacers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final _configurationController = GetIt.instance<ConfigurationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimensions.paddingLarge,
            children: [
              Text(
                'Выберите конфигурацию',
                style: context.textTheme.appTitle,
              ),
              const VSpacer(AppDimensions.paddingExtraSmall),
              ElevatedButton(
                onPressed: () {
                  const value = 'internal';
                  _onTap(value);
                },
                child: const Text('Локальный сервер: 172.17.0.27:81'),
              ),
              ElevatedButton(
                onPressed: () {
                  const value = 'external';
                  _onTap(value);
                },
                child: const Text('Внешний сервер: 95.85.109.86:81'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(String value) {
    _configurationController.changeHost(value);
    // AppInjections.registerAppInjections();
    if (!mounted) {
      return;
    }
    context.goNamed(AppRoutes.initial);
  }
}
