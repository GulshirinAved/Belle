part of '../../form_validator.dart';

class LocaleTk implements FormValidatorLocale {
  const LocaleTk();

  @override
  String name() => 'tk';

  @override
  String minLength(String v, int n) => 'Azyndan $n sany harp bolmaly';

  @override
  String maxLength(String v, int n) => 'Maksimum $n sany harp bolmaly';

  @override
  String email(String v) => 'Girizen elektron adresiňiz ýalňyş';

  @override
  String phoneNumber(String v) => 'Girizen telefonyňyz ýalňyş';

  @override
  String required() => 'Hökman doldyrmaly';

  @override
  String ip(String v) => 'Неверный IP адрес';

  @override
  String ipv6(String v) => 'Неверный IPv6 адрес';

  @override
  String url(String v) => 'Неверный URL адрес';
}
