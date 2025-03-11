// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String locale(String lang) {
    String _temp0 = intl.Intl.selectLogic(
      lang,
      {
        'ru': 'Русский',
        'tk': 'Türkmen',
        'en': 'English',
        'other': 'Другое',
      },
    );
    return '$_temp0';
  }

  @override
  String snack_title(String message) {
    String _temp0 = intl.Intl.selectLogic(
      message,
      {
        'success': 'Успешно',
        'warning': 'Предупреждение',
        'message': 'Сообщение',
        'error': 'Ошибка',
        'other': 'Другое',
      },
    );
    return '$_temp0';
  }

  @override
  String get client => 'Клиент';

  @override
  String get master => 'Мастер';

  @override
  String get show => 'Показать';

  @override
  String get empty => 'Список пуст';

  @override
  String get retry => 'Повторить';

  @override
  String get error_occurred => 'Похоже, возникла проблема. Убедитесь, что ваш интернет работает';

  @override
  String get phone_number => 'Номер телефона';

  @override
  String get password => 'Пароль';

  @override
  String get required => 'Обязательное поле';

  @override
  String phone_between(String start_range, String end_range) {
    return 'Номер телефона должен быть в диапазоне от $start_range до $end_range.';
  }

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get notifications => 'Уведомления';

  @override
  String get no_notifications => 'У вас пока нет уведомлений.';

  @override
  String get name_surname => 'Имя и фамилия';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get enter_info_to_contact => 'Пожалуйста, введите ваше имя и номер телефона, чтобы мастер мог связаться с вами';

  @override
  String get request_sent_success => 'Ваша заявка успешно отправлена.';

  @override
  String get register_to_see_status => 'Если вы хотите узнать статус, пожалуйста, зарегистрируйтесь';

  @override
  String get register_to_see_favorites => 'Пожалуйста, зарегистрируйтесь/войдите, чтобы увидеть избранное';

  @override
  String get show_request_status => 'Показать статус заявки';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get want_to_delete => 'Вы уверены, что хотите удалить?';

  @override
  String get return_to_main => 'Вернуться на главную';

  @override
  String get continue_title => 'Продолжить';

  @override
  String get choose_language => 'Выбрать язык';

  @override
  String get choose_theme => 'Выбрать тему';

  @override
  String get for_women => 'Женщинам';

  @override
  String get for_men => 'Мужчинам';

  @override
  String get woman => 'Женщина';

  @override
  String get man => 'Мужчина';

  @override
  String get top_rated_stylist => 'Лучшие мастера в приложении';

  @override
  String get see_all => 'Посмотреть все';

  @override
  String get profile => 'Профиль';

  @override
  String get new_masters => 'Новые мастера в приложении';

  @override
  String get explore_services => 'Просмотреть услуги';

  @override
  String get no_categories => 'Нет категорий';

  @override
  String get sort => 'Сортировка';

  @override
  String get filter => 'Фильтр';

  @override
  String get book_now => 'Забронировать сейчас';

  @override
  String get apply => 'Применить';

  @override
  String get delete_all => 'Удалить все';

  @override
  String get reset => 'Сбросить';

  @override
  String sort_by(String name, String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'asc': 'По возрастанию',
        'desc': 'По убыванию',
        'other': 'Другое',
      },
    );
    return 'Сортировать по $name ($_temp0)';
  }

  @override
  String get by_price => 'Цена';

  @override
  String get by_rating => 'Лучший рейтинг';

  @override
  String get reviews => 'Отзывы';

  @override
  String get my_services => 'Мои услуги';

  @override
  String get about_me => 'Обо мне';

  @override
  String get choose => 'Выбрать';

  @override
  String get chosen => 'Выбрано';

  @override
  String get choose_date => 'Выберите дату';

  @override
  String get working_hours => 'Рабочие часы';

  @override
  String get home => 'На дому';

  @override
  String get explore => 'Просмотреть';

  @override
  String get clients => 'Клиенты';

  @override
  String get favorites => 'Избранное';

  @override
  String get report => 'Пожаловаться';

  @override
  String get booking => 'Бронирование';

  @override
  String get total_time => 'Общее время';

  @override
  String get total_payment => 'Общая сумма';

  @override
  String get add_more => 'Добавить ещё';

  @override
  String get choose_your_day => 'Выберите свой день';

  @override
  String get show_calendar => 'Показать календарь';

  @override
  String get service_location => 'Место оказания услуги';

  @override
  String get choose_time_for_services => 'Выберите время оказания услуг(и)';

  @override
  String chosen_services(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '1': '1 услуга',
        'other': '$count услуг(и)',
      },
    );
    return 'Выбрано $_temp0';
  }

  @override
  String booking_status(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'reschedule': 'Перезаписано',
        'cancelled': 'Отменено',
        'confirmed': 'Подтверждено',
        'waiting': 'Ожидание',
        'clientArrived': 'Клиент прибыл',
        'completed': 'Завершено',
        'other': 'Не найдено',
      },
    );
    return '$_temp0';
  }

  @override
  String get read => 'Прочитано';

  @override
  String get details => 'Подробности';

  @override
  String get call_title => 'Позвонить';

  @override
  String get search => 'Поиск';

  @override
  String get send_code => 'Отправить код';

  @override
  String get login => 'Войти';

  @override
  String get already_user => 'Уже зарегистрированы?';

  @override
  String get dont_have_account => 'Нет аккаунта?';

  @override
  String get agree_with_policy => 'Я согласен с Пользовательским соглашением; Политикой конфиденциальности и Договором с Мастерами';

  @override
  String get you => 'Вы';

  @override
  String service_locations(String location) {
    String _temp0 = intl.Intl.selectLogic(
      location,
      {
        'in_salon': 'В салоне',
        'away': 'На дому',
        'other': 'Другое',
      },
    );
    return '$_temp0';
  }

  @override
  String get first_name => 'Имя';

  @override
  String get last_name => 'Фамилия';

  @override
  String get we_sent_otp_code => 'Мы отправили сообщение с кодом подтверждения на ваш номер';

  @override
  String please_check_your_phone(String phone_prefix, String phone) {
    return 'Пожалуйста, проверьте ваш номер телефона +993 $phone_prefix ****$phone';
  }

  @override
  String get wrong_code => 'Неверный код';

  @override
  String get send_code_again => 'Отправить код повторно через';

  @override
  String get resend_code => 'Повторно отправить код';

  @override
  String get user_agreement => 'Пользовательское соглашение';

  @override
  String get master_contract => 'Договор с Мастерами';

  @override
  String get privacy => 'Политика конфиденциальности';

  @override
  String get my_bookings => 'Мои записи';

  @override
  String get active => 'Активные';

  @override
  String get history => 'История';

  @override
  String get no_bookings => 'У вас пока нет истории бронирований';

  @override
  String get booking_main_info => 'Основная информация о записи';

  @override
  String get all => 'Все';

  @override
  String get know_languages => 'Знание языков';

  @override
  String get app_version => 'Версия приложения';

  @override
  String get delete_account => 'Удалить аккаунт';

  @override
  String get contact_us => 'Связаться с нами';

  @override
  String get personal_info => 'Личная информация';

  @override
  String get address => 'Адрес';

  @override
  String get save => 'Сохранить';

  @override
  String get main_profile => 'Основной профиль';

  @override
  String get did_not_find => 'Не нашли то, что искали?';

  @override
  String get register_to_suggest_service => 'Вы сможете предложить новую категорию после регистрации';

  @override
  String get email => 'Электронная почта';

  @override
  String get your_gender => 'Ваш пол';

  @override
  String get you_can_change_once_per_month => 'Вы можете изменить этот параметр один раз в месяц';

  @override
  String get logout => 'Выйти';

  @override
  String get add_services => 'Добавить услуги';

  @override
  String get portfolio => 'Портфолио';

  @override
  String get time => 'Время';

  @override
  String get price => 'Цена';

  @override
  String get from => 'От';

  @override
  String get to => 'До';

  @override
  String get make_main => 'Сделать основной';

  @override
  String get service_name => 'Название услуги';

  @override
  String get service_duration => 'Продолжительность услуги';

  @override
  String get service_description => 'Описание услуги (необязательно)';

  @override
  String get fixed_price => 'Фиксированная цена';

  @override
  String get price_range => 'Диапазон цен';

  @override
  String get min_price => 'Минимальная цена';

  @override
  String get max_price => 'Максимальная цена';

  @override
  String get choose_service_category => 'Выберите категорию услуги';

  @override
  String get delete_service => 'Удалить услугу';

  @override
  String get delete_service_desc => 'Вы уверены, что хотите удалить эту услугу?';

  @override
  String get edit_service => 'Редактировать услугу';

  @override
  String get vacation => 'Отпуск/Время отдыха';

  @override
  String get duration => 'Продолжительность';

  @override
  String get working_days => 'Рабочие дни';

  @override
  String get date_start => 'Дата начала';

  @override
  String get break_time => 'Перерыв';

  @override
  String get expired_date => 'Дата окончания';

  @override
  String get not_working_days => 'Нерабочие дни';

  @override
  String get reason => 'Причина';

  @override
  String get schedule => 'Расписание';

  @override
  String get choose_schedule_start_time => 'Выберите время начала расписания';

  @override
  String get choose_schedule_end_time => 'Выберите время окончания расписания';

  @override
  String get cancel => 'Отменить';

  @override
  String get choose_break_start_time => 'Выберите время начала перерыва';

  @override
  String get choose_break_end_time => 'Выберите время окончания перерыва';

  @override
  String get choose_schedule_start_date => 'Выберите дату начала расписания';

  @override
  String get choose_schedule_range => 'Выберите диапазон расписания';

  @override
  String get choose_days => 'Выберите дни';

  @override
  String get frequency => 'Частота';

  @override
  String get choose_reason => 'Выберите причину';

  @override
  String get free_slots_today => 'Свободные слоты сегодня';

  @override
  String get new_message => 'У вас новое сообщение';

  @override
  String get ask_to_reschedule => 'Попросить о перезаписи';

  @override
  String get reschedule => 'Перезаписать';

  @override
  String get hour_short => 'ч';

  @override
  String get minute_short => 'мин';

  @override
  String get this_will_affects_client_search => 'Это повлияет на результаты поиска клиента';

  @override
  String get pick_avatar => 'Выбрать аватар';

  @override
  String get personal_info_updated => 'Личная информация успешно обновлена';

  @override
  String get avatar_updated => 'Аватар успешно обновлен';

  @override
  String get avatar_deleted => 'Аватар успешно удален';

  @override
  String get work_location => 'Место работы';

  @override
  String get select_region => 'Выберите регион';

  @override
  String get select_city => 'Выберите город';

  @override
  String get add_portfolio_images => 'Добавить изображения в портфолио';

  @override
  String get portfolio_images_added_successfully => 'Изображения портфолио успешно добавлены';

  @override
  String get portfolio_images_deleted_successfully => 'Изображения портфолио успешно удалены';

  @override
  String get date => 'Дата';

  @override
  String get services => 'Услуги';

  @override
  String get status => 'Статус';

  @override
  String get text_title => 'Написать';

  @override
  String get complete => 'Завершено';

  @override
  String get add_new_client => 'Добавить клиента';

  @override
  String get choose_day_for_reschedule => 'Выберите день для переноса';

  @override
  String get cancel_booking => 'Отмена брони';

  @override
  String get confirm_cancel_booking => 'Вы точно хотите отменить свой бронь?';

  @override
  String get return_text => 'Возврат';
}
