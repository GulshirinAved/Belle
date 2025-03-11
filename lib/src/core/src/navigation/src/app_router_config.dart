import 'dart:developer';

import 'package:belle/src/features/client/my_bookings/view/reschedule_view.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/master/master.dart';
import '../../../../features/shared/shared.dart';
import '../../../core.dart';

class AppRouterConfig {
  final GoRouter _goRouter;

  AppRouterConfig({
    required GlobalKey<NavigatorState> rootState,
    required GlobalKey<NavigatorState> clientState,
    required GlobalKey<NavigatorState> masterState,
  }) : _goRouter = _configureRouter(
          rootState,
          clientState,
          masterState,
        );

  GoRouter get router => _goRouter;

  /// Configures routes and adding pages there
  static GoRouter _configureRouter(
    GlobalKey<NavigatorState> rootState,
    GlobalKey<NavigatorState> clientState,
    GlobalKey<NavigatorState> masterState,
  ) =>
      GoRouter(
        navigatorKey: rootState,
        debugLogDiagnostics: true,
        initialLocation: AppRoutes.initial,
        routes: [
          // GoRoute(
          //   path: AppRoutes.configuration,
          //   name: AppRoutes.configuration,
          //   builder: (context, state) => const ConfigurationScreen(),
          // ),
          GoRoute(
            path: AppRoutes.initial,
            name: AppRoutes.initial,
            builder: (context, state) {
              return const SplashScreen();
            },
          ),
          GoRoute(
            path: ClientRoutes.personalInfo,
            name: ClientRoutes.personalInfo,
            builder: (context, state) {
              return const ClientPersonalInfoScreen();
            },
          ),
          ..._sharedRoutes(),
          ..._clientInnerRoutes(),
          ..._masterInnerRoutes(),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ClientDashboardScreen(navigationShell: navigationShell);
            },
            branches: _clientRoutes(),
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MasterDashboardScreen(navigationShell: navigationShell);
            },
            branches: _masterRoutes(),
          ),
        ],
      );

  static List<GoRoute> _masterInnerRoutes() {
    return [
      GoRoute(
        path: MasterRoutes.myServices,
        name: MasterRoutes.myServices,
        builder: (context, state) => const MasterMyServicesScreen(),
      ),
      GoRoute(
        path: MasterRoutes.addClient,
        name: MasterRoutes.addClient,
        builder: (context, state) => const MasterAddNewClientScreen(),
      ),
      GoRoute(
        path: MasterRoutes.editClient,
        name: MasterRoutes.editClient,
        builder: (context, state) {
          final data = state.extra as MasterClientDto;

          return MasterEditClientScreen(clientDto: data);
        },
      ),
      GoRoute(
        path: MasterRoutes.workShifts,
        name: MasterRoutes.workShifts,
        builder: (context, state) => const MasterWorkShiftScreen(),
      ),
      GoRoute(
        path: MasterRoutes.editService,
        name: MasterRoutes.editService,
        builder: (context, state) {
          final data = state.extra as MasterServiceDto;
          return MasterEditServiceScreen(data: data);
        },
      ),
      GoRoute(
        path: MasterRoutes.addWorkShift,
        name: MasterRoutes.addWorkShift,
        builder: (context, state) {
          return const MasterAddWorkShiftScreen();
        },
      ),
      GoRoute(
        path: MasterRoutes.editWorkShift,
        name: MasterRoutes.editWorkShift,
        builder: (context, state) {
          final data = state.extra as MasterWorkShiftDto;

          return MasterEditWorkShiftScreen(dto: data);
        },
      ),
      GoRoute(
        path: MasterRoutes.ownServices,
        name: MasterRoutes.ownServices,
        builder: (context, state) {
          final info = state.extra as MasterBookingInfoRouteModel?;

          return MasterServicesScreen(
            time: info?.time,
            chosenServices: info?.chosenServicesToSendDto,
            chosenServicesList: info?.chosenServices,
          );
        },
      ),
      GoRoute(
        path: MasterRoutes.masterBookingClients,
        name: MasterRoutes.masterBookingClients,
        builder: (context, state) {
          final info = state.extra as ChosenMasterServicesToSendDto?;

          return MasterBookingClientsScreen(
            data: info,
          );
        },
      ),
      GoRoute(
        path: MasterRoutes.masterChooseDate,
        name: MasterRoutes.masterChooseDate,
        builder: (context, state) {
          final info = state.extra as ChosenMasterServicesToSendDto?;

          return MasterChooseDateScreen(
            chosenServicesToSendDto: info,
          );
        },
      ),
      GoRoute(
        path: MasterRoutes.masterCreateBooking,
        name: MasterRoutes.masterCreateBooking,
        builder: (context, state) {
          final info = state.extra as MasterCreateBookingDto?;

          return MasterCreateBookingScreen(
            data: info,
          );
        },
      ),
      GoRoute(
        path: MasterRoutes.editVacation,
        name: MasterRoutes.editVacation,
        builder: (context, state) {
          final data = state.extra as MasterHolidayDto;

          return MasterEditVacationScreen(dto: data);
        },
      ),
      GoRoute(
        path: MasterRoutes.addVacation,
        name: MasterRoutes.addVacation,
        builder: (context, state) {
          return const MasterAddVacationScreen();
        },
      ),
      GoRoute(
        path: MasterRoutes.notifications,
        name: MasterRoutes.notifications,
        builder: (context, state) {
          return const MasterNotificationsScreen();
        },
      ),
      GoRoute(
        path: MasterRoutes.personalInfo,
        name: MasterRoutes.personalInfo,
        builder: (context, state) {
          return const MasterPersonalInfoScreen();
        },
      ),
      GoRoute(
        path: MasterRoutes.portfolio,
        name: MasterRoutes.portfolio,
        builder: (context, state) {
          return const MasterPortfolioScreen();
        },
      ),
      GoRoute(
        path: MasterRoutes.clientInfo,
        name: MasterRoutes.clientInfo,
        builder: (context, state) {
          final data = state.extra as MasterClientDto;
          return MasterClientInfoScreen(
            clientDto: data,
          );
        },
      ),
      GoRoute(
        path: MasterRoutes.addNewService,
        name: MasterRoutes.addNewService,
        builder: (context, state) => const MasterAddNewServiceScreen(),
        routes: [
          GoRoute(
            path: MasterRoutes.chooseServiceCategory,
            name: MasterRoutes.chooseServiceCategory,
            builder: (context, state) =>
                const MasterChooseServiceCategoryScreen(),
          ),
          GoRoute(
            path: MasterRoutes.chooseService,
            name: MasterRoutes.chooseService,
            builder: (context, state) {
              final route =
                  state.extra as MasterChooseServiceCategoryRouteModel;
              return MasterChooseServiceScreen(
                name: route.serviceName,
                serviceId: route.serviceId,
                genderId: route.genderId,
              );
            },
          ),
        ],
      ),
    ];
  }

  static List<GoRoute> _clientInnerRoutes() {
    return [
      GoRoute(
        path: ClientRoutes.masterInfo,
        name: ClientRoutes.masterInfo,
        builder: (context, state) => ClientMasterInfoScreen(
          id: (state.extra as Map<String, dynamic>?)?['master_id'] as int?,
        ),
      ),
      GoRoute(
        path: ClientRoutes.bookingNowServices,
        name: ClientRoutes.bookingNowServices,
        builder: (context, state) {
          final info = state.extra as MasterServicesRouteModel?;
          return ClientBookingNowServicesScreen(
            id: info?.masterId,
            chosenServices: const [],
          );
        },
      ),
      GoRoute(
        path: ClientRoutes.booking,
        name: ClientRoutes.booking,
        builder: (context, state) {
          final info = state.extra as BookingInfoRouteModel?;
          return BookingScreen(
            masterInfo: info?.masterInfo,
            chosenServicesToSendDto: info?.chosenServicesToSendDto,
          );
        },
        routes: [
          GoRoute(
            path: ClientRoutes.masterServices,
            name: ClientRoutes.masterServices,
            builder: (context, state) {
              final info = state.extra as MasterServicesRouteModel?;
              return ClientMasterServicesScreen(
                id: info?.masterId,
                chosenServices: info?.chosenServices ?? [],
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: ClientRoutes.makeBooking,
        name: ClientRoutes.makeBooking,
        builder: (context, state) {
          final info = state.extra as BookingDto?;
          return ClientMakeBookingScreen(
            bookingDto: info,
          );
        },
      ),
      GoRoute(
          path: ClientRoutes.myBookings,
          name: ClientRoutes.myBookings,
          builder: (context, state) {
            return const ClientMyBookingsScreen();
          },
          routes: [
            GoRoute(
                path: ClientRoutes.reschedule,
                name: ClientRoutes.reschedule,
                builder: (context, state) {
                  final info = state.extra as ClientBookingsDto;

                  return RescheduleScreen(clientBookingsDto: info);
                })
          ]),
      GoRoute(
        path: ClientRoutes.notifications,
        name: ClientRoutes.notifications,
        builder: (context, state) => const ClientNotificationsScreen(),
      ),
      GoRoute(
        path: ClientRoutes.topStylists,
        name: ClientRoutes.topStylists,
        builder: (context, state) => const ClientTopStylistsScreen(),
      ),
      GoRoute(
        path: ClientRoutes.newMasters,
        name: ClientRoutes.newMasters,
        builder: (context, state) => const ClientNewMastersScreen(),
      ),
      GoRoute(
        path: ClientRoutes.mastersByService,
        name: ClientRoutes.mastersByService,
        builder: (context, state) {
          final serviceData = (state.extra as ClientServiceRouteModel);
          final serviceId = serviceData.serviceId;
          final serviceName = serviceData.serviceName;

          return ClientMastersByServiceScreen(
            serviceId: serviceId,
            serviceName: serviceName,
          );
        },
      ),
    ];
  }

  static List<GoRoute> _sharedRoutes() {
    return [
      GoRoute(
        path: SharedRoutes.login,
        name: SharedRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SharedRoutes.register,
        name: SharedRoutes.register,
        builder: (context, state) => const RegisterScreen(),
        routes: [
          GoRoute(
            path: SharedRoutes.registerMasterServices,
            name: SharedRoutes.registerMasterServices,
            builder: (context, state) {
              return const RegisterMasterServicesScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: SharedRoutes.registerClientOtp,
        name: SharedRoutes.registerClientOtp,
        builder: (context, state) {
          final data = state.extra as RegisterClientDto;
          return RegisterClientOtpScreen(data: data);
        },
      ),
      GoRoute(
        path: SharedRoutes.registerMasterOtp,
        name: SharedRoutes.registerMasterOtp,
        builder: (context, state) {
          final data = state.extra as RegisterMasterDto;
          return RegisterMasterOtpScreen(data: data);
        },
      ),
      GoRoute(
        path: SharedRoutes.loginClientOtp,
        name: SharedRoutes.loginClientOtp,
        builder: (context, state) {
          final data = state.extra as LoginClientDto;
          return LoginClientOtpScreen(data: data);
        },
      ),
      GoRoute(
        path: SharedRoutes.privacyPolicy,
        name: SharedRoutes.privacyPolicy,
        builder: (context, state) {
          return const PrivacyPolicyScreen();
        },
      ),
    ];
  }

  static List<StatefulShellBranch> _clientRoutes() {
    return [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ClientRoutes.home,
            name: ClientRoutes.home,
            builder: (context, state) => const ClientHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ClientRoutes.explore,
            name: ClientRoutes.explore,
            builder: (context, state) => const ClientExploreScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ClientRoutes.favorites,
            name: ClientRoutes.favorites,
            builder: (context, state) => const ClientFavoritesScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ClientRoutes.profile,
            name: ClientRoutes.profile,
            builder: (context, state) => const ClientProfileScreen(),
          ),
        ],
      ),
    ];
  }

  static List<StatefulShellBranch> _masterRoutes() {
    return [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MasterRoutes.home,
            name: MasterRoutes.home,
            builder: (context, state) => const MasterHomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MasterRoutes.clients,
            name: MasterRoutes.clients,
            builder: (context, state) => const MasterClientsScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: MasterRoutes.profile,
            name: MasterRoutes.profile,
            builder: (context, state) => const MasterProfileScreen(),
          ),
        ],
      ),
    ];
  }
}
