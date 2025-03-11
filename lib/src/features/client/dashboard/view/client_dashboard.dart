import 'dart:developer' show log;

import 'package:belle/src/features/master/home/view/master_home.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../shared/src/notifications/data/dto/notification_dto.dart';
import '../../client.dart';

class ClientDashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ClientDashboardScreen({super.key, required this.navigationShell});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  final accountController = GetIt.instance<AuthStatusController>();
  final fireMessage = GetIt.instance<FireMessage>();
  final servicesController = GetIt.instance<ServicesController>();
  final favoritesController = GetIt.instance<ClientFavoritesController>();
  final favoritesStateController =
      GetIt.instance<ClientFavoritesStateController>();
  final masterTypeController = GetIt.instance<MasterTypeController>();
  final roleController = GetIt.instance<RoleController>();

  void onDestinationSelected(int index) {
    if (index == 3 &&
        accountController.authLoginStatus == AuthLoginStatus.notLoggedIn) {
      context.pushNamed(SharedRoutes.register);
      return;
    }

    if (index == 3 && roleController.isMaster) {
      context.go(MasterRoutes.profile);
      return;
    }

    if (widget.navigationShell.currentIndex != index) {
      widget.navigationShell.goBranch(index);
    }
  }

  void _onMessageReceived(Map<String, dynamic> data) {
    ShowSnackHelper.showSnack(
      context,
      SnackStatus.success,
      context.loc.new_message,
      () {
        _handleNotification(data);
      },
      AppColors.gray,
      const Duration(seconds: 8),
    );
  }

  void _handleNotification(Map<String, dynamic> data) async {
    if (data.isEmpty) {
      context.pushNamed(ClientRoutes.notifications);
      return;
    }
    try {
      final notificationData = NotificationDto.fromJson(data);
      final currentRole = roleController.currentRole;
      if (currentRole == UserRole.client) {
        context.pushNamed(ClientRoutes.notifications);
        return;
      }
      if (currentRole == UserRole.master) {
        _handleMasterNotification(notificationData);
      }
    } catch (e) {
      log("Can't parse notification data: $e | Navigate to notifications");
      if (!mounted) {
        return;
      }
      context.pushNamed(ClientRoutes.notifications);
      return;
    }
  }

  void _handleMasterNotification(NotificationDto data) async {
    context.go(MasterRoutes.home);
    context.pushNamed(MasterRoutes.notifications);
  }

  void _onMessageOpenedApp(Map<String, dynamic> data) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _handleNotification(data);
    });
  }

  @override
  void initState() {
    fireMessage.init(_onMessageReceived, _onMessageOpenedApp);
    servicesController.setContext(context);
    favoritesController.setContext(context);
    favoritesStateController.setContext(context);
    favoritesStateController.setBuildContext(context);
    favoritesController.init();
    favoritesStateController.init();
    servicesController.init();
    servicesController.fetchServices(masterTypeController.currentMasterType.id);
    super.initState();
  }

  @override
  void dispose() {
    favoritesController.dispose();
    favoritesStateController.dispose();
    servicesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: widget.navigationShell,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: widget.navigationShell.currentIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home),
                label: context.loc.home,
              ),
              NavigationDestination(
                icon: const Icon(Icons.search),
                label: context.loc.explore,
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_border_rounded),
                label: context.loc.favorites,
              ),
              NavigationDestination(
                icon: const Icon(Icons.menu_open_rounded),
                label: context.loc.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
