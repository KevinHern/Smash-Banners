import 'package:flutter/material.dart';

enum BannerDirection { L, C, R }
enum CustomScale { Background, Character, SocialMedia, PlayerTag, ESports }
enum CustomFlip { Character, SocialMedia }
enum CustomOffset { SocialMedia }
enum CustomColor { SocialMedia, PlayerTag, ESports }
enum CustomFontStyle { SocialMedia, PlayerTag, ESports }
enum CustomFontWeight { SocialMedia, PlayerTag, ESports }
enum CustomPositionX { Character, PlayerTag, ESports }
enum CustomPositionY { Character, PlayerTag, ESports }

class BannerModel extends ChangeNotifier {
  String? encodedBackground, character, eSportsTeam, playerTag;
  int alt, socialMediaColor, eSportsColor, playerTagColor;
  double characterPosX,
      characterPosY,
      playerTagX,
      playerTagY,
      eSportsX,
      eSportsY,
      characterScale,
      backgroundScale,
      socialMediaScale,
      eSportsScale,
      playerTagScale,
      socialMediaOffset;
  FontWeight socialMediaFontWeight, eSportsFontWeight, playerTagFontWeight;
  FontStyle socialMediaFontStyle, eSportsFontStyle, playerTagFontStyle;
  bool fetchingEncodedBackground, flipCharacter, flipSocialMedia;
  final List<String?> socialMedia = [null, null, null, null, null];

  BannerModel({
    @required this.encodedBackground,
    @required this.character,
    this.alt = 1,
    this.fetchingEncodedBackground = false,
    this.flipCharacter = false,
    this.flipSocialMedia = true,
    this.characterPosX = 46,
    this.characterPosY = 23,
    this.playerTagX = 0,
    this.playerTagY = 0,
    this.eSportsX = 0,
    this.eSportsY = 0,
    this.characterScale = 100,
    this.backgroundScale = 100,
    this.socialMediaScale = 100,
    this.eSportsScale = 100,
    this.playerTagScale = 100,
    this.socialMediaOffset = 7,
    this.socialMediaColor = 0xFFAAAAAA,
    this.eSportsColor = 0xFFAAAAAA,
    this.playerTagColor = 0xFFAAAAAA,
    this.socialMediaFontWeight = FontWeight.normal,
    this.socialMediaFontStyle = FontStyle.normal,
    this.eSportsFontWeight = FontWeight.normal,
    this.playerTagFontWeight = FontWeight.normal,
    this.eSportsFontStyle = FontStyle.normal,
    this.playerTagFontStyle = FontStyle.normal,
  });

  void setEncodedBackground(
      {required String? encodedBackground, bool update = false}) {
    this.encodedBackground = encodedBackground;
    if (update) notifyListeners();
  }

  void clearEncodedBackground({bool update = false}) =>
      this.setEncodedBackground(encodedBackground: null, update: update);

  void setFetchingEncodedBackground({required bool status}) {
    this.fetchingEncodedBackground = status;
    notifyListeners();
  }

  void setCharacter({required String? character, bool update = true}) {
    this.character = character;
    if (update) notifyListeners();
  }

  void setESportsTeam({required String? eSportsTeam, bool update = true}) {
    this.eSportsTeam = eSportsTeam;
    if (update) notifyListeners();
  }

  void setPlayerTag({required String? playerTag, bool update = true}) {
    this.playerTag = playerTag;
    if (update) notifyListeners();
  }

  void setAlt({required int alt}) {
    this.alt = alt;
    notifyListeners();
  }

  void setPositionX(
      {required double positionX, required CustomPositionX customPositionX}) {
    switch (customPositionX) {
      case CustomPositionX.Character:
        this.characterPosX = positionX;
        break;
      case CustomPositionX.ESports:
        this.eSportsX = positionX;
        break;
      case CustomPositionX.PlayerTag:
        this.playerTagX = positionX;
        break;
      default:
        throw Exception("Unreachable Option in setPositionY");
    }
    notifyListeners();
  }

  void setPositionY(
      {required double positionY, required CustomPositionY customPositionY}) {
    switch (customPositionY) {
      case CustomPositionY.Character:
        this.characterPosY = positionY;
        break;
      case CustomPositionY.ESports:
        this.eSportsY = positionY;
        break;
      case CustomPositionY.PlayerTag:
        this.playerTagY = positionY;
        break;
      default:
        throw Exception("Unreachable Option in setPositionY");
    }
    notifyListeners();
  }

  void setScale({required double scale, required CustomScale customScale}) {
    switch (customScale) {
      case CustomScale.Background:
        this.backgroundScale = scale;
        break;
      case CustomScale.Character:
        this.characterScale = scale;
        break;
      case CustomScale.SocialMedia:
        this.socialMediaScale = scale;
        break;
      case CustomScale.ESports:
        this.eSportsScale = scale;
        break;
      case CustomScale.PlayerTag:
        this.playerTagScale = scale;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void flip({required bool flip, required CustomFlip customFlip}) {
    switch (customFlip) {
      case CustomFlip.Character:
        this.flipCharacter = flip;
        break;
      case CustomFlip.SocialMedia:
        this.flipSocialMedia = flip;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void offset({required double offset, required CustomOffset customOffset}) {
    switch (customOffset) {
      case CustomOffset.SocialMedia:
        this.socialMediaOffset = offset;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void color({required int colorValue, required CustomColor customColor}) {
    switch (customColor) {
      case CustomColor.SocialMedia:
        this.socialMediaColor = colorValue;
        break;
      case CustomColor.ESports:
        this.eSportsColor = colorValue;
        break;
      case CustomColor.PlayerTag:
        this.playerTagColor = colorValue;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void fontWeight(
      {required FontWeight fontWeight,
      required CustomFontWeight customFontWeight}) {
    switch (customFontWeight) {
      case CustomFontWeight.SocialMedia:
        this.socialMediaFontWeight = fontWeight;
        break;
      case CustomFontWeight.ESports:
        this.eSportsFontWeight = fontWeight;
        break;
      case CustomFontWeight.PlayerTag:
        this.playerTagFontWeight = fontWeight;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void fontStyle(
      {required FontStyle fontStyle,
      required CustomFontStyle customFontStyle}) {
    switch (customFontStyle) {
      case CustomFontStyle.SocialMedia:
        this.socialMediaFontStyle = fontStyle;
        break;
      case CustomFontStyle.ESports:
        this.eSportsFontStyle = fontStyle;
        break;
      case CustomFontStyle.PlayerTag:
        this.playerTagFontStyle = fontStyle;
        break;
      default:
        throw Exception("Unreachable Social Media Platform");
    }
    notifyListeners();
  }

  void setSocialMedia({required int index, @required String? socialMedia}) {
    if (index >= this.socialMedia.length || index < 0)
      throw Exception("Unreachable Social Media Option");
    this.socialMedia[index] = socialMedia;
    notifyListeners();
  }

  void update() => notifyListeners();
}
