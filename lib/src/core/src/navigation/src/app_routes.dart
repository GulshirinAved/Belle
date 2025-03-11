abstract class AppRoutes {
  const AppRoutes._();

  static const initial = '/initial';
  static const configuration = '/configuration';
}

class SharedRoutes extends AppRoutes {
  const SharedRoutes._() : super._();

  static const login = '/login';
  static const register = '/register';
  static const registerClientOtp = '/register_client_otp';
  static const loginClientOtp = '/login_client_otp';
  static const registerMasterOtp = '/register_master_otp';
  static const privacyPolicy = '/privacy_policy';
  static const registerMasterServices = '/register_master_services';
}

class ClientRoutes extends AppRoutes {
  const ClientRoutes._() : super._();

  static const parent = '/client';

  static const home = '$parent/home';
  static const explore = '$parent/explore';
  static const favorites = '$parent/favorites';
  static const profile = '$parent/profile';
  static const masterInfo = '$parent/master_info';
  static const booking = '$parent/booking';
  static const notifications = '$parent/notifications';
  static const makeBooking = '$parent/make_booking';
  static const myBookings = '$parent/my_bookings';
  static const reschedule = '$parent/reschedule';

  static const topStylists = '$parent/top_stylists';
  static const newMasters = '$parent/new_masters';
  static const mastersByService = '$parent/masters_by_service';
  static const masterServices = '$parent/master_services';
  static const bookingNowServices = '$parent/booking_now_services';
  static const personalInfo = '$parent/personal_info';

  static List<String> get all => [
        home,
        explore,
        favorites,
        profile,
        masterInfo,
        booking,
        reschedule,
        notifications,
        makeBooking,
        myBookings,
        topStylists,
        newMasters,
        mastersByService,
        masterServices,
        bookingNowServices,
      ];
}

class MasterRoutes extends AppRoutes {
  const MasterRoutes._() : super._();

  static const parent = '/master';

  static const home = '$parent/home';
  static const clients = '$parent/clients';
  static const profile = '$parent/profile';
  static const myServices = '$parent/my_services';
  static const addNewService = '$parent/add_new_service';
  static const chooseServiceCategory = '$parent/choose_service_category';
  static const chooseService = '$parent/choose_service';
  static const editService = '$parent/edit_service';
  static const workShifts = '$parent/work_shifts';
  static const addWorkShift = '$parent/add_work_shift';
  static const editWorkShift = '$parent/edit_work_shift';
  static const addVacation = '$parent/add_vacation';
  static const editVacation = '$parent/edit_vacation';
  static const notifications = '$parent/notifications';
  static const clientInfo = '$parent/client_info';
  static const personalInfo = '$parent/personal_info';
  static const portfolio = '$parent/portfolio';
  static const addClient = '$parent/add_client';
  static const editClient = '$parent/edit_client';
  static const ownServices = '$parent/own_services';
  static const masterBookingClients = '$parent/master_booking_clients';
  static const masterCreateBooking = '$parent/master_create_booking';
  static const masterChooseDate = '$parent/master_choose_date';

  static List<String> get all => [
        home,
        clients,
        profile,
        myServices,
        addNewService,
        chooseService,
        editService,
        workShifts,
        addWorkShift,
        addVacation,
        notifications,
        clientInfo,
        personalInfo,
        portfolio,
        ownServices,
      ];
}
