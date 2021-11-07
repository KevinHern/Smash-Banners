// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/utilities/utils.dart' as utils;

// Extra Widgets
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

// Models
import 'package:smash_banners/models/banner_model.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';

class CharacterSelectorForm extends StatelessWidget {
  final characterKeyForm = GlobalKey<FormState>();
  final smashServerLink = "https://www.smashbros.com/assets_v2/img/fighter/";
  final List<String> formParameters = [""];
  final List<String> charactersList;

  CharacterSelectorForm({required this.charactersList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerModel>(
          builder: (context, characterModel, __) {
            return DropdownSearch<String>(
              mode: Mode.MENU,
              maxHeight: 470,
              items: charactersList,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Character",
                hintText: "Character",
                hintStyle: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
                ),
                labelStyle: TextStyle(
                  fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
                ),
              ),
              dropdownSearchBaseStyle: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
              ),
              showSearchBox: true,
              onChanged: (value) {
                if (value != null) {
                  switch (value) {
                    case "Donkey Kong":
                    case "Dark Samus":
                    case "Captain Falcon":
                    case "Ice Climbers":
                    case "Young Link":
                    case "Meta Knight":
                    case "Dark Pit":
                    case "Zero Suit Samus":
                    case "Diddy Kong":
                    case "Pokemon Trainer":
                    case "King Dedede":
                    case "Toon Link":
                    case "Mega Man":
                    case "Wii Fit Trainer":
                    case "Little Mac":
                    case "Duck Hunt":
                    case "Piranha Plant":
                      characterModel.setCharacter(
                          character: value.toLowerCase().replaceAll(" ", "_"));
                      break;
                    case "Dr. Mario":
                    case "R.O.B.":
                    case "Bowser Jr.":
                    case "King K. Rool":
                      characterModel.setCharacter(
                          character: value
                              .toLowerCase()
                              .replaceAll(".", "")
                              .replaceAll(" ", "_"));
                      break;
                    case "Mr. Game & Watch":
                      characterModel.setCharacter(
                          character: "mr_game_and_watch");
                      break;
                    case "Rosalina & Luma":
                    case "Banjo & Kazooie":
                      characterModel.setCharacter(
                          character: value
                              .toLowerCase()
                              .replaceAll("&", "and")
                              .replaceAll(" ", "_"));
                      break;
                    case "Mii Brawler":
                    case "Mii Swordfighter":
                    case "Mii Gunner":
                      characterModel.setCharacter(character: "mii_fighter");
                      break;
                    case "Pac-Man":
                      characterModel.setCharacter(
                          character: value.toLowerCase().replaceAll("-", "_"));
                      break;
                    case "Min Min":
                      characterModel.setCharacter(
                          character: value.replaceAll(" ", "").toLowerCase());
                      break;
                    case "Hero":
                      characterModel.setCharacter(character: "dq_hero");
                      break;
                    case "Pyra & Mythra":
                      characterModel.setCharacter(character: "pyra");
                      break;
                    default:
                      characterModel.setCharacter(
                          character: value.toLowerCase());
                  }
                }
              },
              showSelectedItems: true,
              validator: (String? item) {
                if (item == null)
                  return "Required field";
                else
                  return null;
              },
            );
          },
        ),
        utils.EmptySeparator(
          scale: 0.02,
        ),
        FormContainerSection(
          title: "Alt Color",
          child: Consumer<BannerModel>(
            builder: (context, characterModel, __) {
              return SpinBox(
                min: 1,
                max: 8,
                value: (characterModel.alt as double),
                onChanged: (value) =>
                    characterModel.setAlt(alt: (value as int)),
                decimals: 0,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodyText1,
              );
            },
          ),
        ),
      ],
    );
  }
}
