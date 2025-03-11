part of '../../form_validator.dart';

const localeMap = <String, FormValidatorLocale>{
  'ar': LocaleAr(),
  'az': LocaleAz(),
  'ca-es': LocaleCaEs(),
  'de': LocaleDe(),
  'es': LocaleEs(),
  'fr': LocaleFr(),
  'id': LocaleId(),
  'it': LocaleIt(),
  'tr': LocaleTr(),
  'pt-br': LocalePtBr(),
  'ru': LocaleRu(),
  'pl': LocalePl(),
  'zh-cn': LocaleZhCN(),
  'en': LocaleEn(),
  'he': LocaleHe(),
  'ja': LocaleJa(),
  'th': LocaleTh(),
  'vi': LocaleVi(),
  'ro': LocaleRo(),
  'nl': LocaleNl(),
  'tk': LocaleTk(),
};

final supportedLocales = localeMap.keys.toList();

FormValidatorLocale createLocale(String locale) {
  if (locale == 'default') locale = 'en';

  final result = localeMap[locale];
  if (result != null) return result;

  throw ArgumentError.value(
    locale,
    'locale',
    'Form validation locale is not yet supported.',
  );
}
