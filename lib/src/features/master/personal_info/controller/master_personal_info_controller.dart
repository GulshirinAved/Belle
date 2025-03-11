// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';
import 'dart:io';

import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import "package:path/path.dart" as path show basename;

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../shared/shared.dart';
import '../../master.dart';

part 'master_personal_info_controller.g.dart';

class MasterPersonalInfoController extends BaseController<void> {
  final _repository = GetIt.instance<MasterPersonalInfoRepository>();

  Future<void> updateAccountData(MasterPersonalInfoDto data) async {
    await postData(
      () => _repository.updateData(data),
      successMessage: handleContext?.loc.personal_info_updated,
    );
  }
}

class MasterPersonalInfoAvatarUpdateController extends BaseController<void> {
  final _repository = GetIt.instance<MasterPersonalInfoRepository>();

  Future<void> updateAccountAvatar(MultipartFile data) async {
    await postData(
      () => _repository.updateAccountPhoto(data),
      successMessage: handleContext?.loc.avatar_updated,
    );
  }

  Future<void> deleteAccountAvatar() async {
    await postData(
      () => _repository.deleteAccountPhoto(),
      successMessage: handleContext?.loc.avatar_deleted,
    );
  }
}

class MasterPersonalInfoStateController = _MasterPersonalInfoStateControllerBase
    with _$MasterPersonalInfoStateController;

abstract class _MasterPersonalInfoStateControllerBase
    with Store, HandlingErrorMixin {
  @observable
  MasterPersonalInfoDto? _masterPersonalInfoDto;

  @observable
  ObservableList<int> selectedLanguages = ObservableList<int>();

  @observable
  ObservableList<int> selectedServiceLocations = ObservableList<int>();

  @observable
  int gender = 1;

  @observable
  RegionDto? selectedRegion;

  @observable
  CityDto? selectedCity;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  @observable
  String? picturePath;

  @observable
  XFile? picture;

  @observable
  XFile? _tempPicture;

  final ImagePicker picker = ImagePicker();

  bool isNotChanged() {
    return _masterPersonalInfoDto == generateData();
  }

  MasterPersonalInfoDto generateData() {
    return MasterPersonalInfoDto(
      personFn: firstNameController.text,
      personLn: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      idCGender: gender,
      description: aboutMeController.text,
      address: addressController.text,
      languages: selectedLanguages,
      workingLocations: selectedServiceLocations,
      idCCity: selectedCity?.id,
      idCRegion: selectedRegion?.id,
    );
  }

  @action
  void initAccount(AccountDto? value) {
    if (value == null) {
      return;
    }
    _masterPersonalInfoDto = MasterPersonalInfoDto.fromAccountDto(value);
    gender = value.gender?.id ?? 0;
    selectedLanguages.clear();
    selectedLanguages
        .addAll(value.additionalInfo?.languages?.map((e) => e.id ?? 0) ?? []);
    selectedServiceLocations.clear();
    selectedServiceLocations.addAll(
        value.additionalInfo?.workingLocations?.map((e) => e.id ?? 0) ?? []);
    firstNameController.text = value.personFn ?? '';
    lastNameController.text = value.personLn ?? '';
    emailController.text = value.email ?? '';
    phoneController.text = value.phone ?? '';
    aboutMeController.text = value.additionalInfo?.aboutMe ?? '';
    addressController.text = value.address ?? '';
    picturePath = value.additionalInfo?.userImage;
    selectedCity = value.additionalInfo?.city;
    selectedRegion = value.additionalInfo?.region;
  }

  /// ----- IMAGE PICKER LOGIC -----
  Future<XFile?> _pickAnImage(double height, double width) async {
    return await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: width,
      maxHeight: height,
      imageQuality: null,
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

  Future<MultipartFile?> pickTempPicture() async {
    final image = await _pickAnImage(
      AppDimensions.avatarPictureHeight.toDouble(),
      AppDimensions.avatarPictureWidth.toDouble(),
    );
    if (image == null) {
      return null;
    }
    _tempPicture = image;
    final multipartImage = await _formatImage(image);
    return multipartImage;
  }

  @action
  void saveTempImage() {
    if (_tempPicture == null) {
      return;
    }

    picturePath = null;
    picture = _tempPicture;
    _tempPicture = null;
  }

  @action
  void deletePicture() {
    _tempPicture = null;
    picture = null;
    picturePath = null;
  }

  /// ----- END OF IMAGE PICKER LOGIC -----

  @action
  void toggleGender(int value) {
    if (gender == value) {
      return;
    }
    gender = value;
  }

  @action
  void toggleLanguage(int value) {
    if (selectedLanguages.contains(value)) {
      selectedLanguages.remove(value);
      return;
    }
    selectedLanguages.add(value);
  }

  @action
  void toggleServiceLocations(int value) {
    if (selectedServiceLocations.contains(value)) {
      selectedServiceLocations.remove(value);
      return;
    }
    selectedServiceLocations.add(value);
  }

  @action
  void updateCity(CityDto? value) {
    if (selectedCity?.id == value?.id) {
      return;
    }
    selectedCity = value;
  }

  @action
  void updateRegion(RegionDto? value) {
    if (selectedRegion?.id == value?.id) {
      return;
    }
    selectedRegion = value;
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    aboutMeController.dispose();
    addressController.dispose();
  }
}
