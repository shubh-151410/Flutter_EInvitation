// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editormobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditorState on EditorStateBase, Store {
  final _$valueAtom = Atom(name: 'EditorStateBase.value');

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

  final _$listTextStyleAtom = Atom(name: 'EditorStateBase.listTextStyle');

  @override
  List<Map<String, dynamic>> get listTextStyle {
    _$listTextStyleAtom.reportRead();
    return super.listTextStyle;
  }

  @override
  set listTextStyle(List<Map<String, dynamic>> value) {
    _$listTextStyleAtom.reportWrite(value, super.listTextStyle, () {
      super.listTextStyle = value;
    });
  }

  final _$textCardAtom = Atom(name: 'EditorStateBase.textCard');

  @override
  List<String> get textCard {
    _$textCardAtom.reportRead();
    return super.textCard;
  }

  @override
  set textCard(List<String> value) {
    _$textCardAtom.reportWrite(value, super.textCard, () {
      super.textCard = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: 'EditorStateBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$currentIndexTextAtom = Atom(name: 'EditorStateBase.currentIndexText');

  @override
  int get currentIndexText {
    _$currentIndexTextAtom.reportRead();
    return super.currentIndexText;
  }

  @override
  set currentIndexText(int value) {
    _$currentIndexTextAtom.reportWrite(value, super.currentIndexText, () {
      super.currentIndexText = value;
    });
  }

  final _$isMenuOPenAtom = Atom(name: 'EditorStateBase.isMenuOPen');

  @override
  bool get isMenuOPen {
    _$isMenuOPenAtom.reportRead();
    return super.isMenuOPen;
  }

  @override
  set isMenuOPen(bool value) {
    _$isMenuOPenAtom.reportWrite(value, super.isMenuOPen, () {
      super.isMenuOPen = value;
    });
  }

  final _$isControlsAtom = Atom(name: 'EditorStateBase.isControls');

  @override
  bool get isControls {
    _$isControlsAtom.reportRead();
    return super.isControls;
  }

  @override
  set isControls(bool value) {
    _$isControlsAtom.reportWrite(value, super.isControls, () {
      super.isControls = value;
    });
  }

  final _$isFontsAtom = Atom(name: 'EditorStateBase.isFonts');

  @override
  bool get isFonts {
    _$isFontsAtom.reportRead();
    return super.isFonts;
  }

  @override
  set isFonts(bool value) {
    _$isFontsAtom.reportWrite(value, super.isFonts, () {
      super.isFonts = value;
    });
  }

  final _$isColorAtom = Atom(name: 'EditorStateBase.isColor');

  @override
  bool get isColor {
    _$isColorAtom.reportRead();
    return super.isColor;
  }

  @override
  set isColor(bool value) {
    _$isColorAtom.reportWrite(value, super.isColor, () {
      super.isColor = value;
    });
  }

  final _$isOpacityAtom = Atom(name: 'EditorStateBase.isOpacity');

  @override
  bool get isOpacity {
    _$isOpacityAtom.reportRead();
    return super.isOpacity;
  }

  @override
  set isOpacity(bool value) {
    _$isOpacityAtom.reportWrite(value, super.isOpacity, () {
      super.isOpacity = value;
    });
  }

  @override
  String toString() {
    return '''
value: ${value},
listTextStyle: ${listTextStyle},
textCard: ${textCard},
selectedIndex: ${selectedIndex},
currentIndexText: ${currentIndexText},
isMenuOPen: ${isMenuOPen},
isControls: ${isControls},
isFonts: ${isFonts},
isColor: ${isColor},
isOpacity: ${isOpacity}
    ''';
  }
}
