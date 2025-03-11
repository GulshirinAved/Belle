// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkmen (`tk`).
class AppLocalizationsTk extends AppLocalizations {
  AppLocalizationsTk([String locale = 'tk']) : super(locale);

  @override
  String locale(String lang) {
    String _temp0 = intl.Intl.selectLogic(
      lang,
      {
        'ru': 'Rus',
        'tk': 'Türkmen',
        'en': 'Iňlis',
        'other': 'Başga',
      },
    );
    return '$_temp0';
  }

  @override
  String snack_title(String message) {
    String _temp0 = intl.Intl.selectLogic(
      message,
      {
        'success': 'Üstünlik',
        'warning': 'Duýduryş',
        'message': 'Habar',
        'error': 'Ýalňyşlyk',
        'other': 'Başga',
      },
    );
    return '$_temp0';
  }

  @override
  String get client => 'Müşderi';

  @override
  String get master => 'Master';

  @override
  String get show => 'Görkez';

  @override
  String get empty => 'Spisok boş';

  @override
  String get retry => 'Gaýtadan';

  @override
  String get error_occurred => 'Näsazlyk ýüze çykdy. Internet aragatnaşygyňyzy barlaň';

  @override
  String get phone_number => 'Telefon belgisi';

  @override
  String get password => 'Açar sözi';

  @override
  String get required => 'Hökmany';

  @override
  String phone_between(String start_range, String end_range) {
    return 'Telefon belgiňiz $start_range we $end_range aralygynda bolmaly.';
  }

  @override
  String get yes => 'Hawa';

  @override
  String get no => 'Ýok';

  @override
  String get edit => 'Üýtget';

  @override
  String get delete => 'Poz';

  @override
  String get notifications => 'Ýatlamalar';

  @override
  String get no_notifications => 'Häzirki wagtda duýduryş ýok.';

  @override
  String get name_surname => 'Adyňyz we familiýaňyz';

  @override
  String get confirm => 'Tassykla';

  @override
  String get enter_info_to_contact => 'Master siziň bilen habarlaşar ýaly, adyňyzy we telefon belgiňizi giriziň';

  @override
  String get request_sent_success => 'Ýüz tutmaňyz üstünlikli iberildi.';

  @override
  String get register_to_see_status => 'Ýagdaýyny görmek üçin, hasaba duruň';

  @override
  String get register_to_see_favorites => 'Halanlanylanlary görmek üçin hasaba duruň/giriň';

  @override
  String get show_request_status => 'Ýüz tutmaň ýagdaýyny görkez';

  @override
  String get register => 'Hasaba durmak';

  @override
  String get want_to_delete => 'Pozmak isleýärsiňizmi?';

  @override
  String get return_to_main => 'Baş sahypa dolan';

  @override
  String get continue_title => 'Dowam et';

  @override
  String get choose_language => 'Dil saýla';

  @override
  String get choose_theme => 'Tema saýla';

  @override
  String get for_women => 'Aýallara';

  @override
  String get for_men => 'Erkeklere';

  @override
  String get woman => 'Aýal';

  @override
  String get man => 'Erkek';

  @override
  String get top_rated_stylist => 'Iň gowy masterler';

  @override
  String get see_all => 'Hemmesi';

  @override
  String get profile => 'Profil';

  @override
  String get new_masters => 'Täze masterlar';

  @override
  String get explore_services => 'Hyzmatlary gör';

  @override
  String get no_categories => 'Kategoriýa ýok';

  @override
  String get sort => 'Tertiple';

  @override
  String get filter => 'Filtr';

  @override
  String get book_now => 'Häzir belle';

  @override
  String get apply => 'Giriz';

  @override
  String get delete_all => 'Hemmesini poz';

  @override
  String get reset => 'Täzeden düz';

  @override
  String sort_by(String name, String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'asc': 'Ösýän tertipde',
        'desc': 'Kemelýän tertipde',
        'other': 'Başga',
      },
    );
    return '$name boýunça tertiple ($_temp0)';
  }

  @override
  String get by_price => 'Bahasy';

  @override
  String get by_rating => 'Reýtingi';

  @override
  String get reviews => 'Teswirler';

  @override
  String get my_services => 'Hyzmatlarym';

  @override
  String get about_me => 'Men barada';

  @override
  String get choose => 'Saýla';

  @override
  String get chosen => 'Saýlandy';

  @override
  String get choose_date => 'Senäni saýla';

  @override
  String get working_hours => 'Iş wagty';

  @override
  String get home => 'Öýde';

  @override
  String get explore => 'Gözle';

  @override
  String get clients => 'Müşderiler';

  @override
  String get favorites => 'Halanlarym';

  @override
  String get report => 'Şikaýat etmek';

  @override
  String get booking => 'Bellemek';

  @override
  String get total_time => 'Jemi wagty';

  @override
  String get total_payment => 'Jemi töleg';

  @override
  String get add_more => 'Goşmaça goş';

  @override
  String get choose_your_day => 'Günüňizi saýlaň';

  @override
  String get show_calendar => 'Kalendary görkez';

  @override
  String get service_location => 'Hyzmat ýeri';

  @override
  String get choose_time_for_services => 'Hyzmat(lar) üçin wagt saýlaň';

  @override
  String chosen_services(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '1': '1 hyzmat',
        'other': '$count hyzmat',
      },
    );
    return '$_temp0 saýlandy';
  }

  @override
  String booking_status(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'reschedule': 'Täzeden bellik',
        'cancelled': 'Ýatyryldy',
        'confirmed': 'Tassyklandy',
        'waiting': 'Garaşylýar',
        'clientArrived': 'Müşderi geldi',
        'completed': 'Tamamlandy',
        'other': 'Tapylmady',
      },
    );
    return '$_temp0';
  }

  @override
  String get read => 'Okaldy';

  @override
  String get details => 'Giňişleýin';

  @override
  String get call_title => 'Jaň et';

  @override
  String get search => 'Gözleg';

  @override
  String get send_code => 'Kody iber';

  @override
  String get login => 'Giriş';

  @override
  String get already_user => 'Hasabyňyz barmy?';

  @override
  String get dont_have_account => 'Hasabyňyz ýokmy?';

  @override
  String get agree_with_policy => 'Men Ulanyjy şertnamasyny; Gizlinlik syýasatyny we Masterler bilen Şertnamany kabul edýärin';

  @override
  String get you => 'Siz';

  @override
  String service_locations(String location) {
    String _temp0 = intl.Intl.selectLogic(
      location,
      {
        'in_salon': 'Salonda',
        'away': 'Öýde',
        'other': 'Başga',
      },
    );
    return '$_temp0';
  }

  @override
  String get first_name => 'Ady';

  @override
  String get last_name => 'Familiýasy';

  @override
  String get we_sent_otp_code => 'Tassyklama kodyny telefon belgiňize iberdik';

  @override
  String please_check_your_phone(String phone_prefix, String phone) {
    return '+993 $phone_prefix ****$phone belgiňizi barlaň';
  }

  @override
  String get wrong_code => 'Kod ýalňyş';

  @override
  String get send_code_again => 'Kody täzeden iber';

  @override
  String get resend_code => 'Täzeden kody iber';

  @override
  String get user_agreement => 'Ulanyjy şertnamasy';

  @override
  String get master_contract => 'Ussatlar bilen şertnama';

  @override
  String get privacy => 'Gizlinlik syýasaty';

  @override
  String get my_bookings => 'Belliklerim';

  @override
  String get active => 'Aktiw';

  @override
  String get history => 'Taryh';

  @override
  String get no_bookings => 'Häzirki wagtda bellik ýok';

  @override
  String get booking_main_info => 'Bellik barada esasy maglumat';

  @override
  String get all => 'Hemmesi';

  @override
  String get know_languages => 'Bilýän dilleri';

  @override
  String get app_version => 'Programmanyň wersiýasy';

  @override
  String get delete_account => 'Hasaby poz';

  @override
  String get contact_us => 'Biz bilen habarlaşyň';

  @override
  String get personal_info => 'Şahsy maglumat';

  @override
  String get address => 'Salgy';

  @override
  String get save => 'Ýatda sakla';

  @override
  String get main_profile => 'Esasy profil';

  @override
  String get did_not_find => 'Gözleýän zadyňyzy tapmadyňyzmy?';

  @override
  String get register_to_suggest_service => 'Täze kategoriýa teklip etmek üçin hasap açmaly';

  @override
  String get email => 'E-mail';

  @override
  String get your_gender => 'Jynsyňyz';

  @override
  String get you_can_change_once_per_month => 'Bu parametri aýda bir gezek üýtgedip bilersiňiz';

  @override
  String get logout => 'Hasapdan çyk';

  @override
  String get add_services => 'Hyzmat goş';

  @override
  String get portfolio => 'Portfolio';

  @override
  String get time => 'Wagt';

  @override
  String get price => 'Baha';

  @override
  String get from => 'Başlap';

  @override
  String get to => 'Çenli';

  @override
  String get make_main => 'Esasy et';

  @override
  String get service_name => 'Hyzmatyň ady';

  @override
  String get service_duration => 'Hyzmatyň wagty';

  @override
  String get service_description => 'Hyzmat barada düşündiriş (hökmany däl)';

  @override
  String get fixed_price => 'Belli baha';

  @override
  String get price_range => 'Bahalaryň aralygy';

  @override
  String get min_price => 'Iň az baha';

  @override
  String get max_price => 'Iň köp baha';

  @override
  String get choose_service_category => 'Hyzmat kategoriýasyny saýla';

  @override
  String get delete_service => 'Hyzmaty poz';

  @override
  String get delete_service_desc => 'Bu hyzmaty pozmak isleýärsiňizmi?';

  @override
  String get edit_service => 'Hyzmaty üýtget';

  @override
  String get vacation => 'Dynç/Rugsat';

  @override
  String get duration => 'Dowamlylygy';

  @override
  String get working_days => 'Iş günleri';

  @override
  String get date_start => 'Başlangyç senesi';

  @override
  String get break_time => 'Arakesme';

  @override
  String get expired_date => 'Gutarýan senesi';

  @override
  String get not_working_days => 'Dynç günleri';

  @override
  String get reason => 'Sebäbi';

  @override
  String get schedule => 'Iş tertibi';

  @override
  String get choose_schedule_start_time => 'Iş tertibiniň başlaýan wagtyny saýla';

  @override
  String get choose_schedule_end_time => 'Iş tertibiniň gutarýan wagtyny saýla';

  @override
  String get cancel => 'Ýatyr';

  @override
  String get choose_break_start_time => 'Arakesmäniň başlaýan wagtyny saýla';

  @override
  String get choose_break_end_time => 'Arakesmäniň gutarýan wagtyny saýla';

  @override
  String get choose_schedule_start_date => 'Iş tertibiniň başlangyç senesini saýla';

  @override
  String get choose_schedule_range => 'Tertip araçägini saýla';

  @override
  String get choose_days => 'Günleri saýla';

  @override
  String get frequency => 'Ýygylyk';

  @override
  String get choose_reason => 'Sebäbi saýla';

  @override
  String get free_slots_today => 'Günüň boş wagtlary';

  @override
  String get new_message => 'Täze habar';

  @override
  String get ask_to_reschedule => 'Täzeden bellemegi sora';

  @override
  String get reschedule => 'Täzeden bellemek';

  @override
  String get hour_short => 's.';

  @override
  String get minute_short => 'min.';

  @override
  String get this_will_affects_client_search => 'Bu müşderileriň gözleg netijelerine täsir eder';

  @override
  String get pick_avatar => 'Awatar saýla';

  @override
  String get personal_info_updated => 'Şahsy maglumatyňyz üstünlikli täzelendi';

  @override
  String get avatar_updated => 'Awataryňyz üstünlikli täzelendi';

  @override
  String get avatar_deleted => 'Awataryňyz üstünlikli pozuldy';

  @override
  String get work_location => 'Iş ýeri';

  @override
  String get select_region => 'Welaýaty saýla';

  @override
  String get select_city => 'Şäheri saýla';

  @override
  String get add_portfolio_images => 'Portfolio suradyny goş';

  @override
  String get portfolio_images_added_successfully => 'Portfolio suratlary üstünlikli goşuldy';

  @override
  String get portfolio_images_deleted_successfully => 'Portfolio suratlary üstünlikli pozuldy';

  @override
  String get date => 'Sene';

  @override
  String get services => 'Hyzmatlar';

  @override
  String get status => 'Ýagdaýy';

  @override
  String get text_title => 'Ýazmak';

  @override
  String get complete => 'Tamamlamak';

  @override
  String get add_new_client => 'Müşderi goş';

  @override
  String get choose_day_for_reschedule => 'Täzelemek üçin bir gün saýlaň';

  @override
  String get cancel_booking => 'Brony aýyrmak';

  @override
  String get confirm_cancel_booking => 'Siziň bronňyzy hakykatdan hem ýatyrasyňyz gelýärmi?';

  @override
  String get return_text => 'Gaýdyp barmak';
}
