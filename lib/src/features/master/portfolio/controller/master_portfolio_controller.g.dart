// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_portfolio_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterPortfolioStateController
    on _MasterPortfolioStateControllerBase, Store {
  late final _$picturePathsAtom = Atom(
      name: '_MasterPortfolioStateControllerBase.picturePaths',
      context: context);

  @override
  ObservableList<String> get picturePaths {
    _$picturePathsAtom.reportRead();
    return super.picturePaths;
  }

  @override
  set picturePaths(ObservableList<String> value) {
    _$picturePathsAtom.reportWrite(value, super.picturePaths, () {
      super.picturePaths = value;
    });
  }

  late final _$picturesAtom = Atom(
      name: '_MasterPortfolioStateControllerBase.pictures', context: context);

  @override
  ObservableList<XFile> get pictures {
    _$picturesAtom.reportRead();
    return super.pictures;
  }

  @override
  set pictures(ObservableList<XFile> value) {
    _$picturesAtom.reportWrite(value, super.pictures, () {
      super.pictures = value;
    });
  }

  late final _$tempPicturesAtom = Atom(
      name: '_MasterPortfolioStateControllerBase.tempPictures',
      context: context);

  @override
  ObservableList<XFile> get tempPictures {
    _$tempPicturesAtom.reportRead();
    return super.tempPictures;
  }

  @override
  set tempPictures(ObservableList<XFile> value) {
    _$tempPicturesAtom.reportWrite(value, super.tempPictures, () {
      super.tempPictures = value;
    });
  }

  late final _$pickTempPicturesAsyncAction = AsyncAction(
      '_MasterPortfolioStateControllerBase.pickTempPictures',
      context: context);

  @override
  Future<List<MultipartFile>> pickTempPictures(
      {double? maxWidth, double? maxHeight, int? imageQuality}) {
    return _$pickTempPicturesAsyncAction.run(() => super.pickTempPictures(
        maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: imageQuality));
  }

  late final _$pickTempPictureAsyncAction = AsyncAction(
      '_MasterPortfolioStateControllerBase.pickTempPicture',
      context: context);

  @override
  Future<MultipartFile?> pickTempPicture(
      {double? maxWidth, double? maxHeight, int? imageQuality}) {
    return _$pickTempPictureAsyncAction.run(() => super.pickTempPicture(
        maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: imageQuality));
  }

  late final _$_MasterPortfolioStateControllerBaseActionController =
      ActionController(
          name: '_MasterPortfolioStateControllerBase', context: context);

  @override
  void initPictures(List<MasterPortfolioDto> portfolioItems) {
    final _$actionInfo = _$_MasterPortfolioStateControllerBaseActionController
        .startAction(name: '_MasterPortfolioStateControllerBase.initPictures');
    try {
      return super.initPictures(portfolioItems);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void saveTempPictures() {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.saveTempPictures');
    try {
      return super.saveTempPictures();
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deleteTempPicture(XFile image) {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.deleteTempPicture');
    try {
      return super.deleteTempPicture(image);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deleteTempPictures(List<XFile> images) {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.deleteTempPictures');
    try {
      return super.deleteTempPictures(images);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deleteAllTempPictures() {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.deleteAllTempPictures');
    try {
      return super.deleteAllTempPictures();
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  List<XFile> getAllTempPictures() {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.getAllTempPictures');
    try {
      return super.getAllTempPictures();
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String? getTempPicturePath(int index) {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.getTempPicturePath');
    try {
      return super.getTempPicturePath(index);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deletePicture(XFile image) {
    final _$actionInfo = _$_MasterPortfolioStateControllerBaseActionController
        .startAction(name: '_MasterPortfolioStateControllerBase.deletePicture');
    try {
      return super.deletePicture(image);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deletePictures(List<XFile> images) {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.deletePictures');
    try {
      return super.deletePictures(images);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void deleteAllPictures() {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.deleteAllPictures');
    try {
      return super.deleteAllPictures();
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  List<XFile> getAllPictures() {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.getAllPictures');
    try {
      return super.getAllPictures();
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String? getPicturePath(int index) {
    final _$actionInfo =
        _$_MasterPortfolioStateControllerBaseActionController.startAction(
            name: '_MasterPortfolioStateControllerBase.getPicturePath');
    try {
      return super.getPicturePath(index);
    } finally {
      _$_MasterPortfolioStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
picturePaths: ${picturePaths},
pictures: ${pictures},
tempPictures: ${tempPictures}
    ''';
  }
}
