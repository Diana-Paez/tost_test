import 'dart:developer';
import 'dart:io';

import 'package:flutter_test_tots/app/app.locator.dart';
import 'package:flutter_test_tots/app/core/services/cloudinay_service.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_test_tots/app/core/services/auth_service.dart';
import 'package:flutter_test_tots/app/core/services/clients_service.dart';
import 'package:stacked_services/stacked_services.dart';

class ClientDetailViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ClientsService _clientsService = GetIt.instance<ClientsService>();
  final CloudinaryService _cloudinaryService = locator<CloudinaryService>();
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();

  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  File? _photoGalery;

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String? _photo;

  File? get photoGalery => _photoGalery;

  String requestErrorMessage(String type) => 'Error al $type el cliente: ';

  set photoGalery(File? value) {
    _photoGalery = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setAll({
    required String firstName,
    required String lastName,
    required String email,
    required String photo,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _photo = photo;
    _email = email;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhoto(String photoUrl) {
    _photo = photoUrl;
    notifyListeners();
  }

  bool isEnabled() {
    if (_firstName.length >= 4 && _lastName.length >= 4 && _email.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> saveClient() async {
    setBusy(true);
    const String typeError = 'guardar';
    try {
      if (photoGalery != null) {
        await uploadImage(photoGalery!);
      }
      await _clientsService.requestServer(
          token: _authService.token!,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          photo: imageUrl ?? _photo,
          clientMethod: ClientMethod.create);
      _navigationService.back(result: true);

      return true;
    } catch (e) {
      log('$requestErrorMessage($typeError)$e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }

  Future<bool?> updateClient(String id) async {
    setBusy(true);
    const String typeError = 'actualizar';

    try {
      if (photoGalery != null) {
        await uploadImage(photoGalery!);
      }
      await _clientsService.requestServer(
          token: _authService.token!,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          photo: imageUrl ?? _photo,
          id: id,
          clientMethod: ClientMethod.update);
      _navigationService.back(result: true);

      return true;
    } catch (e) {
      log('$requestErrorMessage($typeError)$e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }

  Future<bool?> deleleClient(String id) async {
    setBusy(true);
    const String typeError = 'actualizar';

    try {
      await _clientsService.requestServer(
          token: _authService.token!,
          id: id,
          clientMethod: ClientMethod.delete);
      _navigationService.back(result: true);

      return true;
    } catch (e) {
      log('$requestErrorMessage($typeError)$e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoGalery = File(pickedFile.path);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    setBusy(true);
    try {
      imageUrl = await _cloudinaryService.uploadImage(imageFile);
      notifyListeners();
    } catch (e) {
      log("Error uploading image: $e");
    } finally {
      setBusy(false);
    }
  }
}
