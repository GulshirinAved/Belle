import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generate/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('tk')
  ];

  /// No description provided for @locale.
  ///
  /// In ru, this message translates to:
  /// **'{lang, select, ru{Русский} tk{Türkmen} en{English} other{Другое}}'**
  String locale(String lang);

  /// No description provided for @snack_title.
  ///
  /// In ru, this message translates to:
  /// **'{message, select, success{Успешно} warning{Предупреждение} message{Сообщение} error{Ошибка} other{Другое}}'**
  String snack_title(String message);

  /// No description provided for @client.
  ///
  /// In ru, this message translates to:
  /// **'Клиент'**
  String get client;

  /// No description provided for @master.
  ///
  /// In ru, this message translates to:
  /// **'Мастер'**
  String get master;

  /// No description provided for @show.
  ///
  /// In ru, this message translates to:
  /// **'Показать'**
  String get show;

  /// No description provided for @empty.
  ///
  /// In ru, this message translates to:
  /// **'Список пуст'**
  String get empty;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @error_occurred.
  ///
  /// In ru, this message translates to:
  /// **'Похоже, возникла проблема. Убедитесь, что ваш интернет работает'**
  String get error_occurred;

  /// No description provided for @phone_number.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get phone_number;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @required.
  ///
  /// In ru, this message translates to:
  /// **'Обязательное поле'**
  String get required;

  /// No description provided for @phone_between.
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона должен быть в диапазоне от {start_range} до {end_range}.'**
  String phone_between(String start_range, String end_range);

  /// No description provided for @yes.
  ///
  /// In ru, this message translates to:
  /// **'Да'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @notifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications;

  /// No description provided for @no_notifications.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет уведомлений.'**
  String get no_notifications;

  /// No description provided for @name_surname.
  ///
  /// In ru, this message translates to:
  /// **'Имя и фамилия'**
  String get name_surname;

  /// No description provided for @confirm.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirm;

  /// No description provided for @enter_info_to_contact.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите ваше имя и номер телефона, чтобы мастер мог связаться с вами'**
  String get enter_info_to_contact;

  /// No description provided for @request_sent_success.
  ///
  /// In ru, this message translates to:
  /// **'Ваша заявка успешно отправлена.'**
  String get request_sent_success;

  /// No description provided for @register_to_see_status.
  ///
  /// In ru, this message translates to:
  /// **'Если вы хотите узнать статус, пожалуйста, зарегистрируйтесь'**
  String get register_to_see_status;

  /// No description provided for @register_to_see_favorites.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, зарегистрируйтесь/войдите, чтобы увидеть избранное'**
  String get register_to_see_favorites;

  /// No description provided for @show_request_status.
  ///
  /// In ru, this message translates to:
  /// **'Показать статус заявки'**
  String get show_request_status;

  /// No description provided for @register.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get register;

  /// No description provided for @want_to_delete.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить?'**
  String get want_to_delete;

  /// No description provided for @return_to_main.
  ///
  /// In ru, this message translates to:
  /// **'Вернуться на главную'**
  String get return_to_main;

  /// No description provided for @continue_title.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить'**
  String get continue_title;

  /// No description provided for @choose_language.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать язык'**
  String get choose_language;

  /// No description provided for @choose_theme.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать тему'**
  String get choose_theme;

  /// No description provided for @for_women.
  ///
  /// In ru, this message translates to:
  /// **'Женщинам'**
  String get for_women;

  /// No description provided for @for_men.
  ///
  /// In ru, this message translates to:
  /// **'Мужчинам'**
  String get for_men;

  /// No description provided for @woman.
  ///
  /// In ru, this message translates to:
  /// **'Женщина'**
  String get woman;

  /// No description provided for @man.
  ///
  /// In ru, this message translates to:
  /// **'Мужчина'**
  String get man;

  /// No description provided for @top_rated_stylist.
  ///
  /// In ru, this message translates to:
  /// **'Лучшие мастера в приложении'**
  String get top_rated_stylist;

  /// No description provided for @see_all.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть все'**
  String get see_all;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @new_masters.
  ///
  /// In ru, this message translates to:
  /// **'Новые мастера в приложении'**
  String get new_masters;

  /// No description provided for @explore_services.
  ///
  /// In ru, this message translates to:
  /// **'Просмотреть услуги'**
  String get explore_services;

  /// No description provided for @no_categories.
  ///
  /// In ru, this message translates to:
  /// **'Нет категорий'**
  String get no_categories;

  /// No description provided for @sort.
  ///
  /// In ru, this message translates to:
  /// **'Сортировка'**
  String get sort;

  /// No description provided for @filter.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр'**
  String get filter;

  /// No description provided for @book_now.
  ///
  /// In ru, this message translates to:
  /// **'Забронировать сейчас'**
  String get book_now;

  /// No description provided for @apply.
  ///
  /// In ru, this message translates to:
  /// **'Применить'**
  String get apply;

  /// No description provided for @delete_all.
  ///
  /// In ru, this message translates to:
  /// **'Удалить все'**
  String get delete_all;

  /// No description provided for @reset.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить'**
  String get reset;

  /// No description provided for @sort_by.
  ///
  /// In ru, this message translates to:
  /// **'Сортировать по {name} ({type, select, asc{По возрастанию} desc{По убыванию} other{Другое}})'**
  String sort_by(String name, String type);

  /// No description provided for @by_price.
  ///
  /// In ru, this message translates to:
  /// **'Цена'**
  String get by_price;

  /// No description provided for @by_rating.
  ///
  /// In ru, this message translates to:
  /// **'Лучший рейтинг'**
  String get by_rating;

  /// No description provided for @reviews.
  ///
  /// In ru, this message translates to:
  /// **'Отзывы'**
  String get reviews;

  /// No description provided for @my_services.
  ///
  /// In ru, this message translates to:
  /// **'Мои услуги'**
  String get my_services;

  /// No description provided for @about_me.
  ///
  /// In ru, this message translates to:
  /// **'Обо мне'**
  String get about_me;

  /// No description provided for @choose.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать'**
  String get choose;

  /// No description provided for @chosen.
  ///
  /// In ru, this message translates to:
  /// **'Выбрано'**
  String get chosen;

  /// No description provided for @choose_date.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get choose_date;

  /// No description provided for @working_hours.
  ///
  /// In ru, this message translates to:
  /// **'Рабочие часы'**
  String get working_hours;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'На дому'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In ru, this message translates to:
  /// **'Просмотреть'**
  String get explore;

  /// No description provided for @clients.
  ///
  /// In ru, this message translates to:
  /// **'Клиенты'**
  String get clients;

  /// No description provided for @favorites.
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get favorites;

  /// No description provided for @report.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться'**
  String get report;

  /// No description provided for @booking.
  ///
  /// In ru, this message translates to:
  /// **'Бронирование'**
  String get booking;

  /// No description provided for @total_time.
  ///
  /// In ru, this message translates to:
  /// **'Общее время'**
  String get total_time;

  /// No description provided for @total_payment.
  ///
  /// In ru, this message translates to:
  /// **'Общая сумма'**
  String get total_payment;

  /// No description provided for @add_more.
  ///
  /// In ru, this message translates to:
  /// **'Добавить ещё'**
  String get add_more;

  /// No description provided for @choose_your_day.
  ///
  /// In ru, this message translates to:
  /// **'Выберите свой день'**
  String get choose_your_day;

  /// No description provided for @show_calendar.
  ///
  /// In ru, this message translates to:
  /// **'Показать календарь'**
  String get show_calendar;

  /// No description provided for @service_location.
  ///
  /// In ru, this message translates to:
  /// **'Место оказания услуги'**
  String get service_location;

  /// No description provided for @choose_time_for_services.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время оказания услуг(и)'**
  String get choose_time_for_services;

  /// No description provided for @chosen_services.
  ///
  /// In ru, this message translates to:
  /// **'Выбрано {count, select, 1{1 услуга} other {{count} услуг(и)}}'**
  String chosen_services(String count);

  /// No description provided for @booking_status.
  ///
  /// In ru, this message translates to:
  /// **'{status, select, reschedule{Перезаписано} cancelled{Отменено} confirmed{Подтверждено} waiting{Ожидание} clientArrived{Клиент прибыл} completed{Завершено} other{Не найдено}}'**
  String booking_status(String status);

  /// No description provided for @read.
  ///
  /// In ru, this message translates to:
  /// **'Прочитано'**
  String get read;

  /// No description provided for @details.
  ///
  /// In ru, this message translates to:
  /// **'Подробности'**
  String get details;

  /// No description provided for @call_title.
  ///
  /// In ru, this message translates to:
  /// **'Позвонить'**
  String get call_title;

  /// No description provided for @search.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get search;

  /// No description provided for @send_code.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код'**
  String get send_code;

  /// No description provided for @login.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get login;

  /// No description provided for @already_user.
  ///
  /// In ru, this message translates to:
  /// **'Уже зарегистрированы?'**
  String get already_user;

  /// No description provided for @dont_have_account.
  ///
  /// In ru, this message translates to:
  /// **'Нет аккаунта?'**
  String get dont_have_account;

  /// No description provided for @agree_with_policy.
  ///
  /// In ru, this message translates to:
  /// **'Я согласен с Пользовательским соглашением; Политикой конфиденциальности и Договором с Мастерами'**
  String get agree_with_policy;

  /// No description provided for @you.
  ///
  /// In ru, this message translates to:
  /// **'Вы'**
  String get you;

  /// No description provided for @service_locations.
  ///
  /// In ru, this message translates to:
  /// **'{location, select, in_salon{В салоне} away{На дому} other{Другое}}'**
  String service_locations(String location);

  /// No description provided for @first_name.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In ru, this message translates to:
  /// **'Фамилия'**
  String get last_name;

  /// No description provided for @we_sent_otp_code.
  ///
  /// In ru, this message translates to:
  /// **'Мы отправили сообщение с кодом подтверждения на ваш номер'**
  String get we_sent_otp_code;

  /// No description provided for @please_check_your_phone.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, проверьте ваш номер телефона +993 {phone_prefix} ****{phone}'**
  String please_check_your_phone(String phone_prefix, String phone);

  /// No description provided for @wrong_code.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код'**
  String get wrong_code;

  /// No description provided for @send_code_again.
  ///
  /// In ru, this message translates to:
  /// **'Отправить код повторно через'**
  String get send_code_again;

  /// No description provided for @resend_code.
  ///
  /// In ru, this message translates to:
  /// **'Повторно отправить код'**
  String get resend_code;

  /// No description provided for @user_agreement.
  ///
  /// In ru, this message translates to:
  /// **'Пользовательское соглашение'**
  String get user_agreement;

  /// No description provided for @master_contract.
  ///
  /// In ru, this message translates to:
  /// **'Договор с Мастерами'**
  String get master_contract;

  /// No description provided for @privacy.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get privacy;

  /// No description provided for @my_bookings.
  ///
  /// In ru, this message translates to:
  /// **'Мои записи'**
  String get my_bookings;

  /// No description provided for @active.
  ///
  /// In ru, this message translates to:
  /// **'Активные'**
  String get active;

  /// No description provided for @history.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get history;

  /// No description provided for @no_bookings.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет истории бронирований'**
  String get no_bookings;

  /// No description provided for @booking_main_info.
  ///
  /// In ru, this message translates to:
  /// **'Основная информация о записи'**
  String get booking_main_info;

  /// No description provided for @all.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get all;

  /// No description provided for @know_languages.
  ///
  /// In ru, this message translates to:
  /// **'Знание языков'**
  String get know_languages;

  /// No description provided for @app_version.
  ///
  /// In ru, this message translates to:
  /// **'Версия приложения'**
  String get app_version;

  /// No description provided for @delete_account.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get delete_account;

  /// No description provided for @contact_us.
  ///
  /// In ru, this message translates to:
  /// **'Связаться с нами'**
  String get contact_us;

  /// No description provided for @personal_info.
  ///
  /// In ru, this message translates to:
  /// **'Личная информация'**
  String get personal_info;

  /// No description provided for @address.
  ///
  /// In ru, this message translates to:
  /// **'Адрес'**
  String get address;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @main_profile.
  ///
  /// In ru, this message translates to:
  /// **'Основной профиль'**
  String get main_profile;

  /// No description provided for @did_not_find.
  ///
  /// In ru, this message translates to:
  /// **'Не нашли то, что искали?'**
  String get did_not_find;

  /// No description provided for @register_to_suggest_service.
  ///
  /// In ru, this message translates to:
  /// **'Вы сможете предложить новую категорию после регистрации'**
  String get register_to_suggest_service;

  /// No description provided for @email.
  ///
  /// In ru, this message translates to:
  /// **'Электронная почта'**
  String get email;

  /// No description provided for @your_gender.
  ///
  /// In ru, this message translates to:
  /// **'Ваш пол'**
  String get your_gender;

  /// No description provided for @you_can_change_once_per_month.
  ///
  /// In ru, this message translates to:
  /// **'Вы можете изменить этот параметр один раз в месяц'**
  String get you_can_change_once_per_month;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @add_services.
  ///
  /// In ru, this message translates to:
  /// **'Добавить услуги'**
  String get add_services;

  /// No description provided for @portfolio.
  ///
  /// In ru, this message translates to:
  /// **'Портфолио'**
  String get portfolio;

  /// No description provided for @time.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get time;

  /// No description provided for @price.
  ///
  /// In ru, this message translates to:
  /// **'Цена'**
  String get price;

  /// No description provided for @from.
  ///
  /// In ru, this message translates to:
  /// **'От'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ru, this message translates to:
  /// **'До'**
  String get to;

  /// No description provided for @make_main.
  ///
  /// In ru, this message translates to:
  /// **'Сделать основной'**
  String get make_main;

  /// No description provided for @service_name.
  ///
  /// In ru, this message translates to:
  /// **'Название услуги'**
  String get service_name;

  /// No description provided for @service_duration.
  ///
  /// In ru, this message translates to:
  /// **'Продолжительность услуги'**
  String get service_duration;

  /// No description provided for @service_description.
  ///
  /// In ru, this message translates to:
  /// **'Описание услуги (необязательно)'**
  String get service_description;

  /// No description provided for @fixed_price.
  ///
  /// In ru, this message translates to:
  /// **'Фиксированная цена'**
  String get fixed_price;

  /// No description provided for @price_range.
  ///
  /// In ru, this message translates to:
  /// **'Диапазон цен'**
  String get price_range;

  /// No description provided for @min_price.
  ///
  /// In ru, this message translates to:
  /// **'Минимальная цена'**
  String get min_price;

  /// No description provided for @max_price.
  ///
  /// In ru, this message translates to:
  /// **'Максимальная цена'**
  String get max_price;

  /// No description provided for @choose_service_category.
  ///
  /// In ru, this message translates to:
  /// **'Выберите категорию услуги'**
  String get choose_service_category;

  /// No description provided for @delete_service.
  ///
  /// In ru, this message translates to:
  /// **'Удалить услугу'**
  String get delete_service;

  /// No description provided for @delete_service_desc.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить эту услугу?'**
  String get delete_service_desc;

  /// No description provided for @edit_service.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать услугу'**
  String get edit_service;

  /// No description provided for @vacation.
  ///
  /// In ru, this message translates to:
  /// **'Отпуск/Время отдыха'**
  String get vacation;

  /// No description provided for @duration.
  ///
  /// In ru, this message translates to:
  /// **'Продолжительность'**
  String get duration;

  /// No description provided for @working_days.
  ///
  /// In ru, this message translates to:
  /// **'Рабочие дни'**
  String get working_days;

  /// No description provided for @date_start.
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get date_start;

  /// No description provided for @break_time.
  ///
  /// In ru, this message translates to:
  /// **'Перерыв'**
  String get break_time;

  /// No description provided for @expired_date.
  ///
  /// In ru, this message translates to:
  /// **'Дата окончания'**
  String get expired_date;

  /// No description provided for @not_working_days.
  ///
  /// In ru, this message translates to:
  /// **'Нерабочие дни'**
  String get not_working_days;

  /// No description provided for @reason.
  ///
  /// In ru, this message translates to:
  /// **'Причина'**
  String get reason;

  /// No description provided for @schedule.
  ///
  /// In ru, this message translates to:
  /// **'Расписание'**
  String get schedule;

  /// No description provided for @choose_schedule_start_time.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время начала расписания'**
  String get choose_schedule_start_time;

  /// No description provided for @choose_schedule_end_time.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время окончания расписания'**
  String get choose_schedule_end_time;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отменить'**
  String get cancel;

  /// No description provided for @choose_break_start_time.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время начала перерыва'**
  String get choose_break_start_time;

  /// No description provided for @choose_break_end_time.
  ///
  /// In ru, this message translates to:
  /// **'Выберите время окончания перерыва'**
  String get choose_break_end_time;

  /// No description provided for @choose_schedule_start_date.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату начала расписания'**
  String get choose_schedule_start_date;

  /// No description provided for @choose_schedule_range.
  ///
  /// In ru, this message translates to:
  /// **'Выберите диапазон расписания'**
  String get choose_schedule_range;

  /// No description provided for @choose_days.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дни'**
  String get choose_days;

  /// No description provided for @frequency.
  ///
  /// In ru, this message translates to:
  /// **'Частота'**
  String get frequency;

  /// No description provided for @choose_reason.
  ///
  /// In ru, this message translates to:
  /// **'Выберите причину'**
  String get choose_reason;

  /// No description provided for @free_slots_today.
  ///
  /// In ru, this message translates to:
  /// **'Свободные слоты сегодня'**
  String get free_slots_today;

  /// No description provided for @new_message.
  ///
  /// In ru, this message translates to:
  /// **'У вас новое сообщение'**
  String get new_message;

  /// No description provided for @ask_to_reschedule.
  ///
  /// In ru, this message translates to:
  /// **'Попросить о перезаписи'**
  String get ask_to_reschedule;

  /// No description provided for @reschedule.
  ///
  /// In ru, this message translates to:
  /// **'Перезаписать'**
  String get reschedule;

  /// No description provided for @hour_short.
  ///
  /// In ru, this message translates to:
  /// **'ч'**
  String get hour_short;

  /// No description provided for @minute_short.
  ///
  /// In ru, this message translates to:
  /// **'мин'**
  String get minute_short;

  /// No description provided for @this_will_affects_client_search.
  ///
  /// In ru, this message translates to:
  /// **'Это повлияет на результаты поиска клиента'**
  String get this_will_affects_client_search;

  /// No description provided for @pick_avatar.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать аватар'**
  String get pick_avatar;

  /// No description provided for @personal_info_updated.
  ///
  /// In ru, this message translates to:
  /// **'Личная информация успешно обновлена'**
  String get personal_info_updated;

  /// No description provided for @avatar_updated.
  ///
  /// In ru, this message translates to:
  /// **'Аватар успешно обновлен'**
  String get avatar_updated;

  /// No description provided for @avatar_deleted.
  ///
  /// In ru, this message translates to:
  /// **'Аватар успешно удален'**
  String get avatar_deleted;

  /// No description provided for @work_location.
  ///
  /// In ru, this message translates to:
  /// **'Место работы'**
  String get work_location;

  /// No description provided for @select_region.
  ///
  /// In ru, this message translates to:
  /// **'Выберите регион'**
  String get select_region;

  /// No description provided for @select_city.
  ///
  /// In ru, this message translates to:
  /// **'Выберите город'**
  String get select_city;

  /// No description provided for @add_portfolio_images.
  ///
  /// In ru, this message translates to:
  /// **'Добавить изображения в портфолио'**
  String get add_portfolio_images;

  /// No description provided for @portfolio_images_added_successfully.
  ///
  /// In ru, this message translates to:
  /// **'Изображения портфолио успешно добавлены'**
  String get portfolio_images_added_successfully;

  /// No description provided for @portfolio_images_deleted_successfully.
  ///
  /// In ru, this message translates to:
  /// **'Изображения портфолио успешно удалены'**
  String get portfolio_images_deleted_successfully;

  /// No description provided for @date.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get date;

  /// No description provided for @services.
  ///
  /// In ru, this message translates to:
  /// **'Услуги'**
  String get services;

  /// No description provided for @status.
  ///
  /// In ru, this message translates to:
  /// **'Статус'**
  String get status;

  /// No description provided for @text_title.
  ///
  /// In ru, this message translates to:
  /// **'Написать'**
  String get text_title;

  /// No description provided for @complete.
  ///
  /// In ru, this message translates to:
  /// **'Завершено'**
  String get complete;

  /// No description provided for @add_new_client.
  ///
  /// In ru, this message translates to:
  /// **'Добавить клиента'**
  String get add_new_client;

  /// No description provided for @choose_day_for_reschedule.
  ///
  /// In ru, this message translates to:
  /// **'Выберите день для переноса'**
  String get choose_day_for_reschedule;

  /// No description provided for @cancel_booking.
  ///
  /// In ru, this message translates to:
  /// **'Отмена брони'**
  String get cancel_booking;

  /// No description provided for @confirm_cancel_booking.
  ///
  /// In ru, this message translates to:
  /// **'Вы точно хотите отменить свой бронь?'**
  String get confirm_cancel_booking;

  /// No description provided for @return_text.
  ///
  /// In ru, this message translates to:
  /// **'Возврат'**
  String get return_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru', 'tk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
    case 'tk': return AppLocalizationsTk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
