import 'package:mobx/mobx.dart';

part 'editormobx.g.dart';

class EditorState = EditorStateBase with _$EditorState;

abstract class EditorStateBase with Store {
  @observable
  int value = 0;

  @observable
  List<Map<String, dynamic>> listTextStyle = List<Map<String, dynamic>>();

  

  @observable
  List<String> textCard = List();

  @observable
  int selectedIndex;

  @observable
  int currentIndexText;

  @observable
  bool isMenuOPen = false;
  @observable
  bool isControls = true;
  @observable
  bool isFonts = false;
  @observable
  bool isColor = false;
  @observable
  bool isOpacity = false;
}
