// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiremote.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApiRemote on ApiRemoteBase, Store {
  final _$valueAtom = Atom(name: 'ApiRemoteBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$allCategoryAtom = Atom(name: 'ApiRemoteBase.allCategory');

  @override
  AllCategory get allCategory {
    _$allCategoryAtom.reportRead();
    return super.allCategory;
  }

  @override
  set allCategory(AllCategory value) {
    _$allCategoryAtom.reportWrite(value, super.allCategory, () {
      super.allCategory = value;
    });
  }

  final _$searchCategoryAtom = Atom(name: 'ApiRemoteBase.searchCategory');

  @override
  AllCategory get searchCategory {
    _$searchCategoryAtom.reportRead();
    return super.searchCategory;
  }

  @override
  set searchCategory(AllCategory value) {
    _$searchCategoryAtom.reportWrite(value, super.searchCategory, () {
      super.searchCategory = value;
    });
  }

  final _$stickerModelAtom = Atom(name: 'ApiRemoteBase.stickerModel');

  @override
  StickerModel get stickerModel {
    _$stickerModelAtom.reportRead();
    return super.stickerModel;
  }

  @override
  set stickerModel(StickerModel value) {
    _$stickerModelAtom.reportWrite(value, super.stickerModel, () {
      super.stickerModel = value;
    });
  }

  final _$backgroundCardAtom = Atom(name: 'ApiRemoteBase.backgroundCard');

  @override
  BackgroundCard get backgroundCard {
    _$backgroundCardAtom.reportRead();
    return super.backgroundCard;
  }

  @override
  set backgroundCard(BackgroundCard value) {
    _$backgroundCardAtom.reportWrite(value, super.backgroundCard, () {
      super.backgroundCard = value;
    });
  }

  final _$readyCardAtom = Atom(name: 'ApiRemoteBase.readyCard');

  @override
  ReadyCard get readyCard {
    _$readyCardAtom.reportRead();
    return super.readyCard;
  }

  @override
  set readyCard(ReadyCard value) {
    _$readyCardAtom.reportWrite(value, super.readyCard, () {
      super.readyCard = value;
    });
  }

  final _$qrCodeModelAtom = Atom(name: 'ApiRemoteBase.qrCodeModel');

  @override
  QrCodeModel get qrCodeModel {
    _$qrCodeModelAtom.reportRead();
    return super.qrCodeModel;
  }

  @override
  set qrCodeModel(QrCodeModel value) {
    _$qrCodeModelAtom.reportWrite(value, super.qrCodeModel, () {
      super.qrCodeModel = value;
    });
  }

  final _$qrCodePathAtom = Atom(name: 'ApiRemoteBase.qrCodePath');

  @override
  String get qrCodePath {
    _$qrCodePathAtom.reportRead();
    return super.qrCodePath;
  }

  @override
  set qrCodePath(String value) {
    _$qrCodePathAtom.reportWrite(value, super.qrCodePath, () {
      super.qrCodePath = value;
    });
  }

  final _$getLoginAsyncAction = AsyncAction('ApiRemoteBase.getLogin');

  @override
  Future<dynamic> getLogin(String email, String password) {
    return _$getLoginAsyncAction.run(() => super.getLogin(email, password));
  }

  final _$getRegisterAsyncAction = AsyncAction('ApiRemoteBase.getRegister');

  @override
  Future<dynamic> getRegister(
      String name, String email, String mobile, String password) {
    return _$getRegisterAsyncAction
        .run(() => super.getRegister(name, email, mobile, password));
  }

  final _$getCateoryCardAsyncAction =
      AsyncAction('ApiRemoteBase.getCateoryCard');

  @override
  Future getCateoryCard() {
    return _$getCateoryCardAsyncAction.run(() => super.getCateoryCard());
  }

  final _$getBackGroundAsyncAction = AsyncAction('ApiRemoteBase.getBackGround');

  @override
  Future getBackGround(int categoryId) {
    return _$getBackGroundAsyncAction
        .run(() => super.getBackGround(categoryId));
  }

  final _$getReadyCardAsyncAction = AsyncAction('ApiRemoteBase.getReadyCard');

  @override
  Future getReadyCard() {
    return _$getReadyCardAsyncAction.run(() => super.getReadyCard());
  }

  final _$getQrCodeAsyncAction = AsyncAction('ApiRemoteBase.getQrCode');

  @override
  Future getQrCode(String categoryId) {
    return _$getQrCodeAsyncAction.run(() => super.getQrCode(categoryId));
  }

  final _$getStickerAsyncAction = AsyncAction('ApiRemoteBase.getSticker');

  @override
  Future getSticker() {
    return _$getStickerAsyncAction.run(() => super.getSticker());
  }

  final _$ApiRemoteBaseActionController =
      ActionController(name: 'ApiRemoteBase');

  @override
  void increment() {
    final _$actionInfo = _$ApiRemoteBaseActionController.startAction(
        name: 'ApiRemoteBase.increment');
    try {
      return super.increment();
    } finally {
      _$ApiRemoteBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
allCategory: ${allCategory},
searchCategory: ${searchCategory},
stickerModel: ${stickerModel},
backgroundCard: ${backgroundCard},
readyCard: ${readyCard},
qrCodeModel: ${qrCodeModel},
qrCodePath: ${qrCodePath}
    ''';
  }
}
