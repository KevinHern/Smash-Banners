import 'package:flutter/material.dart';

class CharacterModel extends ChangeNotifier {
  String? character;
  int alt;

  CharacterModel({@required this.character, this.alt = 1});

  void setCharacter({required String? character, bool update = true}) {
    this.character = character;
    if (update) notifyListeners();
  }

  void clearCharacter({bool update = true}) =>
      this.setCharacter(character: null, update: update);

  void setAlt({required int alt}) {
    this.alt = alt;
    notifyListeners();
  }

  void update() => notifyListeners();
}
