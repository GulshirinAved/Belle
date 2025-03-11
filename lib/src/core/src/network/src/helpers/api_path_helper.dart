import 'package:flutter/material.dart';

const _client = 'client';
const _master = 'master';

@immutable
class ApiPathHelper {
  const ApiPathHelper._();

  static String references(ReferencesPath path) {
    const base = 'references';
    switch (path) {
      case ReferencesPath.base:
        return base;
    }
  }

  static String auth(AuthPath path) {
    const base = 'auth';
    switch (path) {
      case AuthPath.clientLogin:
        return '$base/$_client/login';
      case AuthPath.clientRegister:
        return '$base/$_client/register';
      case AuthPath.masterLogin:
        return '$base/$_master/login';
      case AuthPath.masterRegister:
        return '$base/$_master/register';
      case AuthPath.profile:
        return '$base/personal-info';
      case AuthPath.clientLoginVerify:
        return '$base/$_client/login/verify';
      case AuthPath.clientRegisterVerify:
        return '$base/$_client/register/verify';
      case AuthPath.masterRegisterVerify:
        return '$base/$_master/register/verify';
      case AuthPath.tokenRefresh:
        return '$base/token/refresh';
    }
  }

  static String services(ClientServicesPath path) {
    const base = '$_client/services';
    switch (path) {
      case ClientServicesPath.base:
        return base;
    }
  }

  static String masters(MastersPath path, [int? id]) {
    const base = '$_client/masters';
    switch (path) {
      case MastersPath.base:
        return base;
      case MastersPath.byId:
        return '$base/$id';
    }
  }

  static String master(MasterPath path, [int? id]) {
    const base = '$_client/master';
    switch (path) {
      case MasterPath.base:
        return '$base/$id';
      case MasterPath.reviews:
        return '$base/$id/reviews';
    }
  }

  static String notifications(NotificationsPath path) {
    const base = '$_client/notifications';
    switch (path) {
      case NotificationsPath.base:
        return base;
    }
  }

  static String clientNotificationBooking(ClientNotifyBookingPath path) {
    const base = '$_client/notifications-bookings';
    switch (path) {
      case ClientNotifyBookingPath.base:
        return base;
    }
  }

  static String favorites(FavoritesPath path) {
    const base = '$_client/favorites';
    switch (path) {
      case FavoritesPath.base:
        return base;
      case FavoritesPath.delete:
        return '$base/delete';
    }
  }

  static String clientBookings(ClientBookingsPath path) {
    const base = '$_client/personal-bookings';
    switch (path) {
      case ClientBookingsPath.base:
        return base;
    }
  }

  static String chosenServices(ChosenServicesPath path) {
    const base = '$_client/chosen-services';
    switch (path) {
      case ChosenServicesPath.base:
        return base;
    }
  }

  static String createBooking(CreateBookingPath path) {
    const base = '$_client/create-booking';
    switch (path) {
      case CreateBookingPath.base:
        return base;
    }
  }

  static String personalInfo(ClientPersonalBookingPath path) {
    const base = '$_client/personal-bookings';
    switch (path) {
      case ClientPersonalBookingPath.base:
        return base;
      case ClientPersonalBookingPath.edit:
        return '$base/edit';
      case ClientPersonalBookingPath.status:
        return '$base/status';
    }
  }
}

@immutable
class MasterApiPathHelper implements ApiPathHelper {
  const MasterApiPathHelper._();

  static String services(MasterServicesPath path) {
    const base = '$_master/services';
    const masterServices = '$_master/master-services';
    const chooseMainService = '$_master/choose-profile';
    switch (path) {
      case MasterServicesPath.base:
        return base;
      case MasterServicesPath.masterServices:
        return masterServices;
      case MasterServicesPath.chooseMainService:
        return chooseMainService;
    }
  }

  static String service(MasterServicePath path) {
    const base = '$_master/service';
    switch (path) {
      case MasterServicePath.create:
        return '$base/create';
      case MasterServicePath.edit:
        return '$base/edit';
      case MasterServicePath.delete:
        return '$base/delete';
    }
  }

  static String workShifts(MasterWorkShiftsPath path) {
    const base = '$_master/workshifts';
    switch (path) {
      case MasterWorkShiftsPath.base:
        return base;
    }
  }

  static String holidays(MasterHolidaysPath path) {
    const base = '$_master/holidays';
    switch (path) {
      case MasterHolidaysPath.base:
        return base;
    }
  }

  static String workShift(MasterWorkShiftPath path) {
    const base = '$_master/workshift';
    switch (path) {
      case MasterWorkShiftPath.create:
        return '$base/create';
      case MasterWorkShiftPath.edit:
        return '$base/update';
      case MasterWorkShiftPath.delete:
        return '$base/delete';
    }
  }

  static String holiday(MasterHolidayPath path) {
    const base = '$_master/holiday';
    switch (path) {
      case MasterHolidayPath.create:
        return '$base/create';
      case MasterHolidayPath.edit:
        return '$base/edit';
      case MasterHolidayPath.delete:
        return '$base/delete';
    }
  }

  static String contacts(MasterContactsPath path) {
    const base = '$_master/contacts';
    switch (path) {
      case MasterContactsPath.base:
        return base;
      case MasterContactsPath.create:
        return base;
      case MasterContactsPath.edit:
        return '$base/edit';
      case MasterContactsPath.delete:
        return '$base/delete';
    }
  }

  static String bookings(MasterBookingsPath path) {
    const base = '$_master/bookings';
    switch (path) {
      case MasterBookingsPath.base:
        return base;
    }
  }

  static String booking(MasterBookingPath path) {
    const base = '$_master/booking';
    switch (path) {
      case MasterBookingPath.complete:
        return '$base/complete';
      case MasterBookingPath.status:
        return '$base/status';
    }
  }

  static String freeSlots(MasterFreeSlotsPath path) {
    const base = '$_master/free_slots';
    switch (path) {
      case MasterFreeSlotsPath.base:
        return base;
    }
  }

  static String personalInfo(MasterPersonalInfoPath path) {
    const base = '$_master/personal-info';
    switch (path) {
      case MasterPersonalInfoPath.base:
        return base;
      case MasterPersonalInfoPath.edit:
        return '$base/edit';
    }
  }

  static String photo(MasterPhotoPath path) {
    const base = '$_master/photo';
    switch (path) {
      case MasterPhotoPath.base:
        return base;
      case MasterPhotoPath.delete:
        return '$base/delete';
    }
  }

  static String portfolio(MasterPortfolioPath path, [int? id]) {
    const base = '$_master/portfolio';
    switch (path) {
      case MasterPortfolioPath.base:
        return base;
      case MasterPortfolioPath.byId:
        return '$base/$id';
    }
  }

  static String ownServices(MasterOwnServices path) {
    const base = '$_master/own-subservices';
    switch (path) {
      case MasterOwnServices.base:
        return base;
    }
  }

  static String availableDates(MasterAvailableDates path) {
    const base = '$_master/available-dates';
    switch (path) {
      case MasterAvailableDates.base:
        return base;
    }
  }

  static String notifications(MasterNotificationsPath path, [int? id]) {
    const base = '$_master/notifications';
    switch (path) {
      case MasterNotificationsPath.base:
        return base;
      case MasterNotificationsPath.bookings:
        return '$base-bookings';
      case MasterNotificationsPath.delete:
        return '$base/delete';
      case MasterNotificationsPath.types:
        return '$base/types';
      case MasterNotificationsPath.readById:
        assert(id == null, 'Initialize id');
        return '$base/$id/read';
    }
  }
}

enum AuthPath {
  clientLogin,
  clientLoginVerify,
  masterLogin,
  clientRegister,
  clientRegisterVerify,
  masterRegister,
  masterRegisterVerify,
  profile,
  tokenRefresh,
}

enum ClientServicesPath {
  base,
}

enum MastersPath {
  base,
  byId,
}

enum NotificationsPath {
  base,
}

enum ClientNotifyBookingPath {
  base,
}

enum MasterPath {
  base,
  reviews,
}

enum FavoritesPath {
  base,
  delete,
}

enum ClientBookingsPath {
  base,
}

enum ChosenServicesPath {
  base,
}

enum CreateBookingPath {
  base,
}

enum ClientPersonalBookingPath {
  base,
  edit,
  status,
}

enum MasterServicesPath {
  base,
  masterServices,
  chooseMainService,
}

enum MasterServicePath {
  create,
  edit,
  delete,
}

enum MasterWorkShiftsPath {
  base,
}

enum MasterHolidaysPath {
  base,
}

enum MasterWorkShiftPath {
  create,
  edit,
  delete,
}

enum MasterHolidayPath {
  create,
  edit,
  delete,
}

enum MasterContactsPath {
  base,
  create,
  edit,
  delete,
}

enum ReferencesPath {
  base,
}

enum MasterBookingsPath {
  base,
}

enum MasterBookingPath {
  status,
  complete,
}

enum MasterFreeSlotsPath {
  base,
}

enum MasterPersonalInfoPath {
  base,
  edit,
}

enum MasterPhotoPath {
  base,
  delete,
}

enum MasterPortfolioPath {
  base,
  byId,
}

enum MasterNotificationsPath {
  base,
  bookings,
  delete,
  types,
  readById,
}

enum MasterOwnServices {
  base,
}

enum MasterAvailableDates {
  base,
}
