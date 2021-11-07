// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/utilities/utils.dart' as utils;

// Extra Widgets
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:dropdown_search/dropdown_search.dart';

// Models
import 'package:smash_banners/models/banner_model.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';
import 'package:smash_banners/templates/dialog_template.dart';
import 'package:smash_banners/templates/customization_assets.dart';

// Math stuff
import 'dart:convert';
import 'dart:math';

enum CharacterPosition { X, Y }

class AssemblerCharacterPositionCustomization extends StatelessWidget {
  final CharacterPosition position;
  final double initValue;
  final double width;
  AssemblerCharacterPositionCustomization({
    required this.position,
    required this.initValue,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Position " + ((this.position == CharacterPosition.X) ? "X" : "Y"),
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 10),
        Container(
          width: this.width,
          child: SpinBox(
            min: 0,
            max: (this.position == CharacterPosition.X) ? 768 : 384,
            value: this.initValue,
            onChanged: (value) {
              switch (this.position) {
                case CharacterPosition.X:
                  Provider.of<BannerModel>(context, listen: false).setPositionX(
                      positionX: value,
                      customPositionX: CustomPositionX.Character);
                  break;
                case CharacterPosition.Y:
                  Provider.of<BannerModel>(context, listen: false).setPositionY(
                      positionY: value,
                      customPositionY: CustomPositionY.Character);
                  break;
                default:
                  throw Exception("Unreachable state");
              }
            },
            decimals: 0,
            textAlign: TextAlign.center,
            textStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class SocialMediaPlatform extends StatelessWidget {
  final String asset;
  final String label;
  final double scale;
  final int color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;

  SocialMediaPlatform({
    required this.label,
    required this.asset,
    required this.scale,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/" + this.asset + ".png",
            height: 0.2 * this.scale,
            fit: BoxFit.fitHeight,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              this.label,
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontSize: 0.1 * this.scale,
                fontStyle: this.fontStyle,
                fontWeight: this.fontWeight,
                color: Color(this.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssembleSection extends StatelessWidget {
  final smashServerLink = "https://www.smashbros.com/assets_v2/img/fighter/";
  static const double fixedSpacing = 8.0;

  List<Widget> socialPlatforms({required BannerModel bannerModel}) {
    const assets = ['twitch', 'twitter', 'youtube', 'instagram', 'discord'];
    List<Widget> widgets = [];

    for (int i = 0; i < bannerModel.socialMedia.length; i++) {
      if (bannerModel.socialMedia[i] != null)
        widgets.add(
          Flexible(
            flex: 1,
            child: SocialMediaPlatform(
              label: bannerModel.socialMedia[i]!,
              asset: assets[i],
              scale: bannerModel.socialMediaScale,
              color: bannerModel.socialMediaColor,
              fontWeight: bannerModel.socialMediaFontWeight,
              fontStyle: bannerModel.socialMediaFontStyle,
            ),
          ),
        );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<BannerModel>(
          builder: (context, bannerModel, __) {
            return Column(
              children: [
                Text(
                  "Your Banner!",
                  style: Theme.of(context).textTheme.headline1,
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                FormContainerSection(
                  title: "Background Scale (%)",
                  child: Card(
                    child: Slider(
                      min: 1,
                      max: 150,
                      value: bannerModel.backgroundScale,
                      onChanged: (value) => bannerModel.setScale(
                          scale: value, customScale: CustomScale.Background),
                    ),
                  ),
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 384, maxWidth: 768),
                    height: 2.56 * bannerModel.backgroundScale,
                    width: 5.12 * bannerModel.backgroundScale,
                    child: Stack(
                      children: [
                        (bannerModel.encodedBackground != null)
                            ? Center(
                                child: Image.memory(
                                  base64.decode(
                                    bannerModel.encodedBackground!,
                                  ),
                                  //scale:  * 0.01,
                                  width: 5.12 * bannerModel.backgroundScale,
                                  alignment: FractionalOffset.center,
                                  fit: BoxFit.fill,
                                  colorBlendMode: BlendMode.color,
                                ),
                              )
                            : Container(),
                        (bannerModel.character != null)
                            ? Positioned(
                                top: bannerModel.characterPosY,
                                left: bannerModel.characterPosX,
                                child: SizedBox(
                                  height: 2.1 * bannerModel.characterScale,
                                  child: Image.network(
                                    this.smashServerLink +
                                        bannerModel.character! +
                                        "/main" +
                                        ((bannerModel.alt != 1)
                                            ? bannerModel.alt.toString()
                                            : "") +
                                        ".png",
                                    fit: BoxFit.fitHeight,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null)
                                        return Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(
                                              bannerModel.flipCharacter
                                                  ? pi
                                                  : 0),
                                          child: child,
                                        );
                                      return Container(
                                        height: 220,
                                        width: 450,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                "Getting Fighter...",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: (bannerModel.flipSocialMedia)
                              ? Alignment.topCenter
                              : Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: bannerModel.flipSocialMedia
                                  ? bannerModel.socialMediaOffset
                                  : 0,
                              bottom: bannerModel.flipSocialMedia
                                  ? 0
                                  : bannerModel.socialMediaOffset,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: this
                                  .socialPlatforms(bannerModel: bannerModel),
                            ),
                          ),
                        ),
                        (bannerModel.eSportsTeam != null)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: bannerModel.eSportsY,
                                  left: bannerModel.eSportsX,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    bannerModel.eSportsTeam!,
                                    style: TextStyle(
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .fontFamily,
                                      fontSize: 0.2 * bannerModel.eSportsScale,
                                      fontStyle: bannerModel.eSportsFontStyle,
                                      fontWeight: bannerModel.eSportsFontWeight,
                                      color: Color(bannerModel.eSportsColor),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        (bannerModel.playerTag != null)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: bannerModel.playerTagY,
                                  left: bannerModel.playerTagX,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    bannerModel.playerTag!,
                                    style: TextStyle(
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .fontFamily,
                                      fontSize:
                                          0.2 * bannerModel.playerTagScale,
                                      fontStyle: bannerModel.playerTagFontStyle,
                                      fontWeight:
                                          bannerModel.playerTagFontWeight,
                                      color: Color(bannerModel.playerTagColor),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                ChangeNotifierProvider<ValueNotifier<int?>>(
                  create: (context) => ValueNotifier<int?>(null),
                  child: Column(
                    children: [
                      Consumer<ValueNotifier<int?>>(
                        builder: (context, customizeOption, __) {
                          return DropdownSearch<String>(
                            mode: Mode.MENU,
                            maxHeight: 125,
                            items: [
                              "Character",
                              "Social",
                              "Player Tag",
                              "E-Sports Team"
                            ],
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Customize",
                              hintText: "Customize",
                              hintStyle: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .fontFamily,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .fontFamily,
                              ),
                              icon: Icon(
                                Icons.edit,
                                size: 40,
                              ),
                            ),
                            dropdownSearchBaseStyle: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                            ),
                            onChanged: (value) {
                              switch (value) {
                                case null:
                                  break;
                                case "Character":
                                  customizeOption.value = 0;
                                  break;
                                case "Social":
                                  customizeOption.value = 1;
                                  break;
                                case "Player Tag":
                                  customizeOption.value = 2;
                                  break;
                                case "E-Sports Team":
                                  customizeOption.value = 3;
                                  break;
                                default:
                                  throw Exception(
                                      "Unreachable option in Customization Style");
                              }
                            },
                            showSelectedItems: true,
                          );
                        },
                      ),
                      utils.EmptySeparator(
                        scale: 0.02,
                      ),
                      Consumer<ValueNotifier<int?>>(
                        builder: (context, customizeOption, __) {
                          switch (customizeOption.value) {
                            case null:
                              return Container();
                            case 0:
                              return FormContainer(
                                child: Center(
                                  child: Column(
                                    children: [
                                      CustomizeSwitch(
                                        title: 'Flip Character',
                                        value: bannerModel.flipCharacter,
                                        onChanged: (value) => bannerModel.flip(
                                          flip: value,
                                          customFlip: CustomFlip.Character,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: fixedSpacing,
                                      ),
                                      CustomizeSlider(
                                        title: 'Position X',
                                        min: 0,
                                        max: MediaQuery.of(context).size.width *
                                            0.85,
                                        initValue: bannerModel.characterPosX,
                                        onChanged: (value) =>
                                            bannerModel.setPositionX(
                                          positionX: value,
                                          customPositionX:
                                              CustomPositionX.Character,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: fixedSpacing,
                                      ),
                                      CustomizeSlider(
                                        title: 'Position Y',
                                        min: 0,
                                        max:
                                            MediaQuery.of(context).size.height *
                                                0.90,
                                        initValue: bannerModel.characterPosY,
                                        onChanged: (value) =>
                                            bannerModel.setPositionY(
                                          positionY: value,
                                          customPositionY:
                                              CustomPositionY.Character,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: fixedSpacing,
                                      ),
                                      CustomizeSlider(
                                        title: "Scale (%)",
                                        min: 1,
                                        max: 150,
                                        initValue: bannerModel.characterScale,
                                        onChanged: (value) =>
                                            bannerModel.setScale(
                                                scale: value,
                                                customScale:
                                                    CustomScale.Character),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            case 1:
                              return FormContainer(
                                child: Column(
                                  children: [
                                    CustomizeColor(
                                      colorValue: bannerModel.socialMediaColor,
                                      title: "Font Color",
                                      onColorChanged: (colorValue) =>
                                          bannerModel.color(
                                        colorValue: colorValue,
                                        customColor: CustomColor.SocialMedia,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Bold Font",
                                      value:
                                          bannerModel.socialMediaFontWeight ==
                                              FontWeight.bold,
                                      onChanged: (value) =>
                                          bannerModel.fontWeight(
                                        fontWeight: value
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        customFontWeight:
                                            CustomFontWeight.SocialMedia,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Italic Font",
                                      value: bannerModel.socialMediaFontStyle ==
                                          FontStyle.italic,
                                      onChanged: (value) =>
                                          bannerModel.fontStyle(
                                        fontStyle: value
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                        customFontStyle:
                                            CustomFontStyle.SocialMedia,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Top Position",
                                      value: bannerModel.flipSocialMedia,
                                      onChanged: (value) => bannerModel.flip(
                                        flip: value,
                                        customFlip: CustomFlip.SocialMedia,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Offset",
                                      min: 2,
                                      max: 20,
                                      initValue: bannerModel.socialMediaOffset,
                                      onChanged: (value) => bannerModel.offset(
                                        offset: value,
                                        customOffset: CustomOffset.SocialMedia,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Scale (%)",
                                      min: 80,
                                      max: 150,
                                      initValue: bannerModel.socialMediaScale,
                                      onChanged: (value) =>
                                          bannerModel.setScale(
                                        scale: value,
                                        customScale: CustomScale.SocialMedia,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            case 2:
                              return FormContainer(
                                child: Column(
                                  children: [
                                    CustomizeSlider(
                                      title: "Position X",
                                      min: 0,
                                      max: MediaQuery.of(context).size.width *
                                          0.45,
                                      initValue: bannerModel.playerTagX,
                                      onChanged: (value) =>
                                          bannerModel.setPositionX(
                                        positionX: value,
                                        customPositionX:
                                            CustomPositionX.PlayerTag,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Position Y",
                                      min: 0,
                                      max: MediaQuery.of(context).size.height *
                                          0.35,
                                      initValue: bannerModel.playerTagY,
                                      onChanged: (value) =>
                                          bannerModel.setPositionY(
                                        positionY: value,
                                        customPositionY:
                                            CustomPositionY.PlayerTag,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Scale (%)",
                                      min: 80,
                                      max: 250,
                                      initValue: bannerModel.playerTagScale,
                                      onChanged: (value) =>
                                          bannerModel.setScale(
                                        scale: value,
                                        customScale: CustomScale.PlayerTag,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeColor(
                                      colorValue: bannerModel.playerTagColor,
                                      title: "Font Color",
                                      onColorChanged: (colorValue) =>
                                          bannerModel.color(
                                        colorValue: colorValue,
                                        customColor: CustomColor.PlayerTag,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Bold Font",
                                      value: bannerModel.playerTagFontWeight ==
                                          FontWeight.bold,
                                      onChanged: (value) =>
                                          bannerModel.fontWeight(
                                        fontWeight: value
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        customFontWeight:
                                            CustomFontWeight.PlayerTag,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Italic Font",
                                      value: bannerModel.playerTagFontStyle ==
                                          FontStyle.italic,
                                      onChanged: (value) =>
                                          bannerModel.fontStyle(
                                        fontStyle: value
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                        customFontStyle:
                                            CustomFontStyle.PlayerTag,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            case 3:
                              return FormContainer(
                                child: Column(
                                  children: [
                                    CustomizeSlider(
                                      title: "Position X",
                                      min: 0,
                                      max: MediaQuery.of(context).size.width *
                                          0.45,
                                      initValue: bannerModel.eSportsX,
                                      onChanged: (value) =>
                                          bannerModel.setPositionX(
                                        positionX: value,
                                        customPositionX:
                                            CustomPositionX.ESports,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Position Y",
                                      min: 0,
                                      max: MediaQuery.of(context).size.height *
                                          0.35,
                                      initValue: bannerModel.eSportsY,
                                      onChanged: (value) =>
                                          bannerModel.setPositionY(
                                        positionY: value,
                                        customPositionY:
                                            CustomPositionY.ESports,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSlider(
                                      title: "Scale (%)",
                                      min: 80,
                                      max: 250,
                                      initValue: bannerModel.eSportsScale,
                                      onChanged: (value) =>
                                          bannerModel.setScale(
                                        scale: value,
                                        customScale: CustomScale.ESports,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeColor(
                                      colorValue: bannerModel.eSportsColor,
                                      title: "Font Color",
                                      onColorChanged: (colorValue) =>
                                          bannerModel.color(
                                        colorValue: colorValue,
                                        customColor: CustomColor.ESports,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Bold Font",
                                      value: bannerModel.eSportsFontWeight ==
                                          FontWeight.bold,
                                      onChanged: (value) =>
                                          bannerModel.fontWeight(
                                        fontWeight: value
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        customFontWeight:
                                            CustomFontWeight.ESports,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: fixedSpacing,
                                    ),
                                    CustomizeSwitch(
                                      title: "Italic Font",
                                      value: bannerModel.eSportsFontStyle ==
                                          FontStyle.italic,
                                      onChanged: (value) =>
                                          bannerModel.fontStyle(
                                        fontStyle: value
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                        customFontStyle:
                                            CustomFontStyle.ESports,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            default:
                              return AlertTextTemplate(
                                  title: "Warning",
                                  message: "Unreachable Customize Option",
                                  showAction: false);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
