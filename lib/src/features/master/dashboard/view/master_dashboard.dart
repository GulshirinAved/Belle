import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../shared/src/notifications/data/dto/notification_dto.dart';
import '../../master.dart';

class MasterDashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MasterDashboardScreen({super.key, required this.navigationShell});

  @override
  State<MasterDashboardScreen> createState() => _MasterDashboardScreenState();
}

class _MasterDashboardScreenState extends State<MasterDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.navigationShell,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (widget.navigationShell.currentIndex != index) {
            widget.navigationShell.goBranch(index);
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: context.loc.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.groups_outlined),
            label: context.loc.clients,
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu_open_rounded),
            label: context.loc.profile,
          ),
        ],
      ),
    );
  }
}
