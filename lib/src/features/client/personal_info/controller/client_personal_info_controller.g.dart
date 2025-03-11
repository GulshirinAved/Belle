// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_personal_info_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientPersonalInfoController
    on _ClientPersonalInfoControllerBase, Store {
  late final _$genderAtom =
      Atom(name: '_ClientPersonalInfoControllerBase.gender', context: context);

  @override
  int get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(int value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$_ClientPersonalInfoControllerBaseActionController =
      ActionController(
          name: '_ClientPersonalInfoControllerBase', context: context);

  @override
  void toggleGender(int value) {
    final _$actionInfo = _$_ClientPersonalInfoControllerBaseActionController
        .startAction(name: '_ClientPersonalInfoControllerBase.toggleGender');
    try {
      return super.toggleGender(value);
    } finally {
      _$_ClientPersonalInfoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gender: ${gender}
    ''';
  }
}
