// ignore_for_file: library_private_types_in_public_api

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/api_models/src/pagination_params.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobx/mobx.dart';

import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;

part 'master_portfolio_controller.g.dart';

class MasterPortfolioController extends BaseController<MasterPortfolioDto> {
  final _repository = GetIt.instance<MasterPortfolioRepository>();

  Future<void> fetchPortfolio() async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchPortfolio(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }

  Future<void> fetchMorePortfolio() async {
    await loadMoreListData(
      ({int? size, int? number}) => _repository.fetchPortfolio(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }
}

class MasterPortfolioImagesController extends BaseController<void> {
  final _repository = GetIt.instance<MasterPortfolioRepository>();

  Future<void> addPortfolioImages({required List<MultipartFile> photos}) async {
    await postData(
      () => _repository.addPortfolioImages(photos: photos),
      successMessage: handleContext!.loc.portfolio_images_added_successfully,
    );
  }

  Future<void> deletePortfolioImage({required int id}) async {
    await postData(
      () => _repository.deletePortfolioImage(id: id),
      successMessage: handleContext!.loc.portfolio_images_deleted_successfully,
    );
  }
}

class MasterPortfolioStateController = _MasterPortfolioStateControllerBase
    with _$MasterPortfolioStateController;

abstract class _MasterPortfolioStateControllerBase
    with Store, HandlingErrorMixin {
  @observable
  ObservableList<String> picturePaths = ObservableList<String>();

  @observable
  ObservableList<XFile> pictures = ObservableList<XFile>();

  @observable
  ObservableList<XFile> tempPictures = ObservableList<XFile>();

  final ImagePicker picker = ImagePicker();

  /// ----- IMAGE PICKER LOGIC -----
  Future<XFile?> _pickAnImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return await picker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
  }

  Future<List<XFile>> _pickMultipleImages({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return await picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
  }

  File _formatImageToFile(XFile? image) {
    return File(image?.path ?? '');
  }

  Future<MultipartFile> _formatImage(XFile? image) async {
    final photoFile = _formatImageToFile(image);
    MultipartFile multipartImage;
    try {
      if (photoFile.path.isEmpty) {
        throw Exception('no path provided');
      }
      String fileName = path.basename(photoFile.path);
      log("File Name : $fileName");
      log("File Size : ${photoFile.lengthSync()}");
      multipartImage =
          await MultipartFile.fromFile(photoFile.path, filename: fileName);
      return multipartImage;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @action
  void initPictures(List<MasterPortfolioDto> portfolioItems) {
    for (var item in portfolioItems) {
      if (item.imageUrl != null) {
        picturePaths.add(item.imageUrl!);
      }
    }
  }

  @action
  Future<List<MultipartFile>> pickTempPictures({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    final images = await _pickMultipleImages(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    if (images.isEmpty) {
      return [];
    }
    tempPictures.addAll(images);
    final list = <MultipartFile>[];
    for (final image in images) {
      list.add(await _formatImage(image));
    }
    return list;
  }

  @action
  Future<MultipartFile?> pickTempPicture({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    final image = await _pickAnImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    if (image == null) {
      return null;
    }
    tempPictures.add(image);
    return await _formatImage(image);
  }

  @action
  void saveTempPictures() {
    pictures.addAll(tempPictures);
    tempPictures.clear();
  }

  @action
  void deleteTempPicture(XFile image) {
    tempPictures.remove(image);
  }

  @action
  void deleteTempPictures(List<XFile> images) {
    tempPictures.removeWhere((element) => images.contains(element));
  }

  @action
  void deleteAllTempPictures() {
    tempPictures.clear();
  }

  @action
  List<XFile> getAllTempPictures() {
    return tempPictures;
  }

  @action
  String? getTempPicturePath(int index) {
    if (index >= 0 && index < tempPictures.length) {
      return tempPictures[index].path;
    }
    return null;
  }

  @action
  void deletePicture(XFile image) {
    pictures.remove(image);
  }

  @action
  void deletePictures(List<XFile> images) {
    pictures.removeWhere((element) => images.contains(element));
  }

  @action
  void deleteAllPictures() {
    pictures.clear();
  }

  @action
  List<XFile> getAllPictures() {
    return pictures;
  }

  @action
  String? getPicturePath(int index) {
    if (index >= 0 && index < pictures.length) {
      return pictures[index].path;
    }
    return null;
  }
}
