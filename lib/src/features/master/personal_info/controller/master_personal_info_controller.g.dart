// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_personal_info_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterPersonalInfoStateController
    on _MasterPersonalInfoStateControllerBase, Store {
  late final _$_masterPersonalInfoDtoAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase._masterPersonalInfoDto',
      context: context);

  @override
  MasterPersonalInfoDto? get _masterPersonalInfoDto {
    _$_masterPersonalInfoDtoAtom.reportRead();
    return super._masterPersonalInfoDto;
  }

  @override
  set _masterPersonalInfoDto(MasterPersonalInfoDto? value) {
    _$_masterPersonalInfoDtoAtom
        .reportWrite(value, super._masterPersonalInfoDto, () {
      super._masterPersonalInfoDto = value;
    });
  }

  late final _$selectedLanguagesAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.selectedLanguages',
      context: context);

  @override
  ObservableList<int> get selectedLanguages {
    _$selectedLanguagesAtom.reportRead();
    return super.selectedLanguages;
  }

  @override
  set selectedLanguages(ObservableList<int> value) {
    _$selectedLanguagesAtom.reportWrite(value, super.selectedLanguages, () {
      super.selectedLanguages = value;
    });
  }

  late final _$selectedServiceLocationsAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.selectedServiceLocations',
      context: context);

  @override
  ObservableList<int> get selectedServiceLocations {
    _$selectedServiceLocationsAtom.reportRead();
    return super.selectedServiceLocations;
  }

  @override
  set selectedServiceLocations(ObservableList<int> value) {
    _$selectedServiceLocationsAtom
        .reportWrite(value, super.selectedServiceLocations, () {
      super.selectedServiceLocations = value;
    });
  }

  late final _$genderAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.gender', context: context);

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

  late final _$selectedRegionAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.selectedRegion',
      context: context);

  @override
  RegionDto? get selectedRegion {
    _$selectedRegionAtom.reportRead();
    return super.selectedRegion;
  }

  @override
  set selectedRegion(RegionDto? value) {
    _$selectedRegionAtom.reportWrite(value, super.selectedRegion, () {
      super.selectedRegion = value;
    });
  }

  late final _$selectedCityAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.selectedCity',
      context: context);

  @override
  CityDto? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(CityDto? value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  late final _$picturePathAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.picturePath',
      context: context);

  @override
  String? get picturePath {
    _$picturePathAtom.reportRead();
    return super.picturePath;
  }

  @override
  set picturePath(String? value) {
    _$picturePathAtom.reportWrite(value, super.picturePath, () {
      super.picturePath = value;
    });
  }

  late final _$pictureAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase.picture', context: context);

  @override
  XFile? get picture {
    _$pictureAtom.reportRead();
    return super.picture;
  }

  @override
  set picture(XFile? value) {
    _$pictureAtom.reportWrite(value, super.picture, () {
      super.picture = value;
    });
  }

  late final _$_tempPictureAtom = Atom(
      name: '_MasterPersonalInfoStateControllerBase._tempPicture',
      context: context);

  @override
  XFile? get _tempPicture {
    _$_tempPictureAtom.reportRead();
    return super._tempPicture;
  }

  @override
  set _tempPicture(XFile? value) {
    _$_tempPictureAtom.reportWrite(value, super._tempPicture, () {
      super._tempPicture = value;
    });
  }

  late final _$_MasterPersonalInfoStateControllerBaseActionController =
      ActionController(
          name: '_MasterPersonalInfoStateControllerBase', context: context);

  @override
  void initAccount(AccountDto? value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.initAccount');
    try {
      return super.initAccount(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void saveTempImage() {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.saveTempImage');
    try {
      return super.saveTempImage();
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deletePicture() {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.deletePicture');
    try {
      return super.deletePicture();
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void toggleGender(int value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.toggleGender');
    try {
      return super.toggleGender(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void toggleLanguage(int value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.toggleLanguage');
    try {
      return super.toggleLanguage(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void toggleServiceLocations(int value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name:
                '_MasterPersonalInfoStateControllerBase.toggleServiceLocations');
    try {
      return super.toggleServiceLocations(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void updateCity(CityDto? value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.updateCity');
    try {
      return super.updateCity(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void updateRegion(RegionDto? value) {
    final _$actionInfo =
        _$_MasterPersonalInfoStateControllerBaseActionController.startAction(
            name: '_MasterPersonalInfoStateControllerBase.updateRegion');
    try {
      return super.updateRegion(value);
    } finally {
      _$_MasterPersonalInfoStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLanguages: ${selectedLanguages},
selectedServiceLocations: ${selectedServiceLocations},
gender: ${gender},
selectedRegion: ${selectedRegion},
selectedCity: ${selectedCity},
picturePath: ${picturePath},
picture: ${picture}
    ''';
  }
}
