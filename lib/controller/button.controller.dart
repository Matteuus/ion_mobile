import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'button.controller.g.dart';

class ButtonController = ButtonControllerBase with _$ButtonController;

abstract class ButtonControllerBase with Store {
  @observable
  Color color = Colors.white;
}
