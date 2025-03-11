// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String locale(String lang) {
    String _temp0 = intl.Intl.selectLogic(
      lang,
      {
        'ru': 'Русский',
        'tk': 'Türkmen',
        'en': 'English',
        'other': 'Не найдено',
      },
    );
    return '$_temp0';
  }

  @override
  String snack_title(String message) {
    String _temp0 = intl.Intl.selectLogic(
      message,
      {
        'success': 'Success',
        'warning': 'Warning',
        'message': 'Message',
        'error': 'Error',
        'other': 'Не найдено',
      },
    );
    return '$_temp0';
  }

  @override
  String get client => 'Client';

  @override
  String get master => 'Master';

  @override
  String get show => 'Show';

  @override
  String get empty => 'List is empty';

  @override
  String get retry => 'Retry';

  @override
  String get error_occurred => 'Looks like there\'s a problem. Make sure your internet\'s working.';

  @override
  String get phone_number => 'Phone number';

  @override
  String get password => 'Password';

  @override
  String get required => 'Required field';

  @override
  String phone_between(String start_range, String end_range) {
    return 'Phone number must be in range of $start_range - $end_range.';
  }

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get notifications => 'Notifications';

  @override
  String get no_notifications => 'You don\'t have any notifications yet.';

  @override
  String get name_surname => 'Name and surname';

  @override
  String get confirm => 'Confirm';

  @override
  String get enter_info_to_contact => 'Please enter your name and phone number. So that the master can contact you';

  @override
  String get request_sent_success => 'Your request has been successfully sent.';

  @override
  String get register_to_see_status => 'If you want to see your status, please register.';

  @override
  String get register_to_see_favorites => 'Please Register/Login to see favorites';

  @override
  String get show_request_status => 'Show request status';

  @override
  String get register => 'Register';

  @override
  String get want_to_delete => 'Are you sure want to delete?';

  @override
  String get return_to_main => 'Return to main';

  @override
  String get continue_title => 'Continue';

  @override
  String get choose_language => 'Choose language';

  @override
  String get choose_theme => 'Choose theme';

  @override
  String get for_women => 'Women';

  @override
  String get for_men => 'Men';

  @override
  String get woman => 'Woman';

  @override
  String get man => 'Man';

  @override
  String get top_rated_stylist => 'Top rated stylist';

  @override
  String get see_all => 'See All';

  @override
  String get profile => 'Profile';

  @override
  String get new_masters => 'New masters on Belle';

  @override
  String get explore_services => 'Explore services';

  @override
  String get no_categories => 'No categories';

  @override
  String get sort => 'Sort';

  @override
  String get filter => 'Filter';

  @override
  String get book_now => 'Book now';

  @override
  String get apply => 'Apply';

  @override
  String get delete_all => 'Delete all';

  @override
  String get reset => 'Reset';

  @override
  String sort_by(String name, String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'asc': 'Ascending',
        'desc': 'Descending',
        'other': 'Other',
      },
    );
    return 'Sort by $name ($_temp0)';
  }

  @override
  String get by_price => 'Price';

  @override
  String get by_rating => 'Best rating';

  @override
  String get reviews => 'Reviews';

  @override
  String get my_services => 'My services';

  @override
  String get about_me => 'About me';

  @override
  String get choose => 'Choose';

  @override
  String get chosen => 'Chosen';

  @override
  String get choose_date => 'Choose a date';

  @override
  String get working_hours => 'Working hours';

  @override
  String get home => 'Home';

  @override
  String get explore => 'Explore';

  @override
  String get clients => 'Clients';

  @override
  String get favorites => 'Favorites';

  @override
  String get report => 'Report';

  @override
  String get booking => 'Booking';

  @override
  String get total_time => 'Total time';

  @override
  String get total_payment => 'Total payment';

  @override
  String get add_more => 'Add more';

  @override
  String get choose_your_day => 'Choose your day';

  @override
  String get show_calendar => 'Show calendar';

  @override
  String get service_location => 'Service location';

  @override
  String get choose_time_for_services => 'Choose time for selected services';

  @override
  String chosen_services(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '1': '1 service',
        'other': '$count services',
      },
    );
    return 'Chosen $_temp0';
  }

  @override
  String booking_status(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'reschedule': 'Request for re-recording',
        'cancelled': 'Cancelled',
        'confirmed': 'Confirmed',
        'waiting': 'Waiting',
        'clientArrived': 'Client arrived',
        'completed': 'Completed',
        'other': 'Not found',
      },
    );
    return '$_temp0';
  }

  @override
  String get read => 'Read';

  @override
  String get details => 'Details';

  @override
  String get call_title => 'Call';

  @override
  String get search => 'Search';

  @override
  String get send_code => 'Send code';

  @override
  String get login => 'Login';

  @override
  String get already_user => 'Already a user?';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get agree_with_policy => 'Я согласен с Пользовательским соглашением; Политикой конфиденциальности';

  @override
  String get you => 'You';

  @override
  String service_locations(String location) {
    String _temp0 = intl.Intl.selectLogic(
      location,
      {
        'in_salon': 'In salon',
        'away': 'Away',
        'other': 'Other',
      },
    );
    return '$_temp0';
  }

  @override
  String get first_name => 'First name';

  @override
  String get last_name => 'Last name';

  @override
  String get we_sent_otp_code => 'We have sent a message with a confirmation code to your number.';

  @override
  String please_check_your_phone(String phone_prefix, String phone) {
    return 'Please check your phone number +993 $phone_prefix ****$phone';
  }

  @override
  String get wrong_code => 'Wrong code';

  @override
  String get send_code_again => 'Send the code again in ';

  @override
  String get resend_code => 'Resend code';

  @override
  String get user_agreement => 'User agreement';

  @override
  String get master_contract => 'Contract with masters';

  @override
  String get privacy => 'Privacy policy';

  @override
  String get my_bookings => 'My bookings';

  @override
  String get active => 'Active';

  @override
  String get history => 'History';

  @override
  String get no_bookings => 'You don\'t have a booking history yet.';

  @override
  String get booking_main_info => 'Booking main info';

  @override
  String get all => 'All';

  @override
  String get know_languages => 'Know languages';

  @override
  String get app_version => 'App version';

  @override
  String get delete_account => 'Delete account';

  @override
  String get contact_us => 'Contact Us';

  @override
  String get personal_info => 'Personal info';

  @override
  String get address => 'Address';

  @override
  String get save => 'Save';

  @override
  String get main_profile => 'Main profile';

  @override
  String get did_not_find => 'Didn’t find what you were looking for?';

  @override
  String get register_to_suggest_service => 'You can suggest a new category after registering.';

  @override
  String get email => 'Email';

  @override
  String get your_gender => 'Your gender';

  @override
  String get you_can_change_once_per_month => 'You can change this option once per month';

  @override
  String get logout => 'Logout';

  @override
  String get add_services => 'Add services';

  @override
  String get portfolio => 'Portfolio';

  @override
  String get time => 'Time';

  @override
  String get price => 'Price';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get make_main => 'Make main';

  @override
  String get service_name => 'Service name';

  @override
  String get service_duration => 'Service duration';

  @override
  String get service_description => 'Service description (optional)';

  @override
  String get fixed_price => 'Fixed price';

  @override
  String get price_range => 'Price range';

  @override
  String get min_price => 'Min price';

  @override
  String get max_price => 'Max price';

  @override
  String get choose_service_category => 'Choose service category';

  @override
  String get delete_service => 'Delete service';

  @override
  String get delete_service_desc => 'Are you sure to delete this service?';

  @override
  String get edit_service => 'Edit service';

  @override
  String get vacation => 'Vacation/Time off';

  @override
  String get duration => 'Duration';

  @override
  String get working_days => 'Working days';

  @override
  String get date_start => 'Date start';

  @override
  String get break_time => 'Break';

  @override
  String get expired_date => 'Expired date';

  @override
  String get not_working_days => 'Not working days';

  @override
  String get reason => 'Reason';

  @override
  String get schedule => 'Schedule';

  @override
  String get choose_schedule_start_time => 'Choose schedule start time';

  @override
  String get choose_schedule_end_time => 'Choose schedule end time';

  @override
  String get cancel => 'Cancel';

  @override
  String get choose_break_start_time => 'Choose break start time';

  @override
  String get choose_break_end_time => 'Choose break end time';

  @override
  String get choose_schedule_start_date => 'Choose schedule start date';

  @override
  String get choose_schedule_range => 'Choose schedule range';

  @override
  String get choose_days => 'Choose days';

  @override
  String get frequency => 'Frequency';

  @override
  String get choose_reason => 'Choose reason';

  @override
  String get free_slots_today => 'Free slots today';

  @override
  String get new_message => 'You\'ve just got a new message';

  @override
  String get ask_to_reschedule => 'Ask to reschedule';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get hour_short => 'h';

  @override
  String get minute_short => 'min';

  @override
  String get this_will_affects_client_search => 'This will affect the client\'s search results';

  @override
  String get pick_avatar => 'Pick avatar';

  @override
  String get personal_info_updated => 'Personal info updated successfully';

  @override
  String get avatar_updated => 'Avatar was updated successfully';

  @override
  String get avatar_deleted => 'Avatar was deleted successfully';

  @override
  String get work_location => 'Work location';

  @override
  String get select_region => 'Select region';

  @override
  String get select_city => 'Select city';

  @override
  String get add_portfolio_images => 'Add portfolio images';

  @override
  String get portfolio_images_added_successfully => 'Portfolio images added successfully';

  @override
  String get portfolio_images_deleted_successfully => 'Portfolio images deleted successfully';

  @override
  String get date => 'Date';

  @override
  String get services => 'Services';

  @override
  String get status => 'Status';

  @override
  String get text_title => 'Text';

  @override
  String get complete => 'Complete';

  @override
  String get add_new_client => 'Add new client';

  @override
  String get choose_day_for_reschedule => 'Select a day to rescheduling';

  @override
  String get cancel_booking => 'Cancel booking';

  @override
  String get confirm_cancel_booking => 'Are you sure you want to cancel your booking?';

  @override
  String get return_text => 'Return';
}
