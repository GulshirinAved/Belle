import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/client/notifications/controller/client_notification_booking_controller.dart';
import 'package:belle/src/features/client/notifications/data/repository/client_notification_booking_repository.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/language/language.dart';
import '../../../features/master/master.dart';
import '../../../theme/theme.dart';
import '../../core.dart';

@immutable
class AppInjections {
  const AppInjections._();

  static void registerBasicInjections() {
    final getIt = GetIt.instance;

    getIt.registerSingleton<KeyValueStorageService>(KeyValueStorageService());
    getIt.registerSingleton(LanguageController());
    getIt.registerSingleton(ThemeController());
    getIt.registerSingleton(FireMessage());
    getIt.registerSingleton(MasterTypeController());

    getIt.registerSingleton<ConfigurationController>(ConfigurationController());
  }

  static void registerAppInjections() {
    final getIt = GetIt.instance;

    getIt.registerSingleton<Dio>(AppHttpClient.configureClient(
        getIt<ConfigurationController>().selectedHost));
    _registerRepositories(getIt);

    _registerSingletonControllers(getIt);
    _registerFactoryControllers(getIt);
  }

  /// Registering singleton controllers
  static void _registerSingletonControllers(GetIt getIt) {
    getIt.registerSingleton(AuthStatusController());
    getIt.registerSingleton(ServicesController());
    getIt.registerSingleton(ClientFavoritesController());
    getIt.registerSingleton(ClientFavoritesStateController());
    getIt.registerSingleton(AccountController());
    getIt.registerSingleton(RoleController());
    getIt.registerLazySingleton(() => ReferencesController());
  }

  /// Registering singleton repositories
  static void _registerRepositories(GetIt getIt) {
    getIt.registerSingleton(AccountRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientHomeRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientExploreRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientMasterInfoRepository(getIt<Dio>()));
    getIt.registerSingleton(RegisterRepository(getIt<Dio>()));
    getIt.registerSingleton(LoginRepository(getIt<Dio>()));
    getIt.registerSingleton(OtpRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientMyBookingsRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientFavoritesRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientTopStylistsRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientNewMastersRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientMastersByServiceRepository(getIt<Dio>()));
    getIt.registerSingleton(BookingRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientMakeBookingRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientNotificationsRepository(getIt<Dio>()));
    getIt.registerSingleton(ClientBookingNotificationsRepository(getIt<Dio>()));

    getIt.registerSingleton(MasterMyServicesRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterAddNewServiceRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterEditServiceRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterServicesRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterWorkShiftRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterHolidaysRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterAddWorkShiftRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterEditWorkShiftRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterEditVacationRepository(getIt<Dio>()));
    getIt.registerSingleton(ReferencesRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterAddVacationRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterHomeRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterBookingRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterClientsRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterPersonalInfoRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterPortfolioRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterNotificationsRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterOwnServicesRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterMakeBookingRepository(getIt<Dio>()));
    getIt.registerSingleton(MasterChosenServicesRepository(getIt<Dio>()));
  }

  /// Registering factory controllers
  static void _registerFactoryControllers(GetIt getIt) {
    getIt.registerFactory(() => ClientHomeController());
    getIt.registerFactory(() => SplashController());
    getIt.registerFactory(() => ClientExploreController());
    getIt.registerFactory(() => ClientExploreSearchController());
    getIt.registerFactory(() => ClientMasterInfoController());
    getIt.registerFactory(() => ClientMasterReviewsController());
    getIt.registerFactory(() => ClientMasterInfoStateController());
    getIt.registerFactory(() => RegisterClientController());
    getIt.registerFactory(() => RegisterMasterController());
    getIt.registerFactory(() => RegisterMasterServicesController());
    getIt.registerFactory(() => RegisterMasterServicesStateController());
    getIt.registerFactory(() => LoginClientController());
    getIt.registerFactory(() => LoginMasterController());
    getIt.registerFactory(() => LoginClientOtpController());
    getIt.registerFactory(() => RegisterMasterOtpController());
    getIt.registerFactory(() => RegisterClientOtpController());
    getIt.registerFactory(() => ClientMyBookingsController());
    getIt.registerFactory(() => ClientMyBookingsStateController());
    getIt.registerFactory(() => ClientBookingMasterInfoController());
    getIt.registerFactory(() => ClientBookingStatusController());

    getIt.registerFactory(() => ClientBookingCalendarController());
    getIt.registerFactory(() => ClientTopStylistsController());
    getIt.registerFactory(() => ClientNewMastersController());
    getIt.registerFactory(() => ClientMastersByServiceController());
    getIt.registerFactory(() => BookingController());
    getIt.registerFactory(() => BookingStateController());
    getIt.registerFactory(() => ClientMasterServicesController());
    getIt.registerFactory(() => ClientBookingNowServicesController());
    getIt.registerFactory(() => ClientMasterServicesStateController());
    getIt.registerFactory(() => ClientMakeBookingController());
    getIt.registerFactory(() => BookingCalendarController());
    getIt.registerFactory(() => ClientBookingNowServicesStateController());
    getIt.registerFactory(() => ClientNotificationsController());
    getIt.registerFactory(() => ClientNotificationBookingController());
    getIt.registerFactory(() => ClientPersonalInfoController());
    getIt.registerFactory(() => MasterMyServicesController());
    getIt.registerFactory(() => MasterAddNewServiceController());
    getIt.registerFactory(() => MasterAddNewServiceStateController());
    getIt.registerFactory(() => MasterEditServiceController());
    getIt.registerFactory(() => MasterEditServiceStateController());
    getIt.registerFactory(() => MasterChooseServiceController());
    getIt.registerFactory(() => MasterMyServicesStateController());
    getIt.registerFactory(() => MasterMyServicesEditController());
    getIt.registerFactory(() => MasterWorkShiftsController());
    getIt.registerFactory(() => MasterHolidaysController());
    getIt.registerFactory(() => MasterAddWorkShiftController());
    getIt.registerFactory(() => MasterAddWorkShiftStateController());
    getIt.registerFactory(() => MasterEditWorkShiftController());
    getIt.registerFactory(() => MasterEditWorkShiftStateController());
    getIt.registerFactory(() => MasterEditVacationStateController());
    getIt.registerFactory(() => MasterEditVacationController());
    getIt.registerFactory(() => MasterAddVacationStateController());
    getIt.registerFactory(() => MasterAddVacationController());
    getIt.registerFactory(() => MasterBookingController());
    getIt.registerFactory(() => MasterClientsController());
    getIt.registerFactory(() => MasterPersonalInfoStateController());
    getIt.registerFactory(() => MasterPersonalInfoController());
    getIt.registerFactory(() => MasterPersonalInfoAvatarUpdateController());
    getIt.registerFactory(() => ReferencesForRegionsController());
    getIt.registerFactory(() => MasterPortfolioController());
    getIt.registerFactory(() => MasterPortfolioImagesController());
    getIt.registerFactory(() => MasterPortfolioStateController());
    getIt.registerFactory(() => MasterNotificationsController());
    getIt.registerFactory(() => MasterAddNewClientController());
    getIt.registerFactory(() => MasterClientInfoController());
    getIt.registerFactory(() => MasterEditClientController());
    getIt.registerFactory(() => MasterEditClientStateController());
    getIt.registerFactory(() => MasterAddNewClientStateController());
    getIt.registerFactory(() => MasterServicesController());
    getIt.registerFactory(() => MasterServicesStateController());
    getIt.registerFactory(() => MasterBookingClientsStateController());
    getIt.registerFactory(() => MasterCreateBookingController());
    getIt.registerFactory(() => MasterChosenServicesController());
    getIt.registerFactory(() => MasterChosenServicesCalendarController());
    getIt.registerFactory(() => MasterChosenServicesStateController());
    getIt.registerFactory<MasterHomeController>(() => MasterHomeController());
    getIt.registerFactory<MasterHomeStateController>(
        () => MasterHomeStateController());
  }
}
