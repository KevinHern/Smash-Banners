// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/models/banner_model.dart';
import 'utilities/utils.dart' as utils;

// Widget imports
import 'package:expandable/expandable.dart';

// Sub Widgets
import 'smash_banner_subwidgets/background_generator.dart';
import 'smash_banner_subwidgets/character_selector.dart';
import 'smash_banner_subwidgets/social_media.dart';
import 'smash_banner_subwidgets/player_information.dart';
import 'smash_banner_subwidgets/assemble.dart';

// Templates
import 'package:smash_banners/templates/dialog_template.dart';

class SmashBannerExpandable extends StatelessWidget {
  final String title;
  final Widget richText;
  final Widget expanded;
  SmashBannerExpandable(
      {required this.title, required this.richText, required this.expanded});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpandablePanel(
        header: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                child: FloatingActionButton(
                  elevation: 2.0,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/info.png',
                    scale: 2.5,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertRichTextTemplate(
                          title: "Details",
                          richText: this.richText,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                this.title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
        collapsed: Container(),
        expanded: Padding(
          padding: const EdgeInsets.all(16.0),
          child: this.expanded,
        ),
      ),
    );
  }
}

class SmashBannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/smash_bros.png',
          scale: 0.9,
        ),
        title: Text(
          "Smash Bros Banner Generator",
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
            fontSize: Theme.of(context).textTheme.headline1!.fontSize,
            color: Colors.white.withOpacity(0.90),
          ),
        ),
      ),
      body: SmashBannerBody(),
    );
  }
}

class SmashBannerBody extends StatelessWidget {
  static const List<String> charactersList = [
    "Mario",
    "Donkey Kong",
    "Link",
    "Samus",
    "Dark Samus",
    "Yoshi",
    "Kirby",
    "Fox",
    "Pikachu",
    "Luigi",
    "Ness",
    "Captain Falcon",
    "Jigglypuff",
    "Peach",
    "Daisy",
    "Bowser",
    "Ice Climbers",
    "Sheik",
    "Zelda",
    "Dr. Mario",
    "Pichu",
    "Falco",
    "Marth",
    "Lucina",
    "Young Link",
    "Ganondorf",
    "Mewtwo",
    "Roy",
    "Chrom",
    "Mr. Game & Watch",
    "Meta Knight",
    "Pit",
    "Dark Pit",
    "Zero Suit Samus",
    "Wario",
    "Snake",
    "Ike",
    "Pokemon Trainer",
    "Diddy Kong",
    "Lucas",
    "Sonic",
    "King Dedede",
    "Olimar",
    "Lucario",
    "R.O.B.",
    "Toon Link",
    "Wolf",
    "Villager",
    "Mega Man",
    "Wii Fit Trainer",
    "Rosalina & Luma",
    "Little Mac",
    "Greninja",
    "Mii Brawler",
    "Mii Swordfighter",
    "Mii Gunner",
    "Palutena",
    "Pac-Man",
    "Robin",
    "Shulk",
    "Bowser Jr.",
    "Duck Hunt",
    "Ryu",
    "Ken",
    "Cloud",
    "Corrin",
    "Bayonetta",
    "Inkling",
    "Ridley",
    "Simon",
    "Richter",
    "King K. Rool",
    "Isabelle",
    "Incineroar",
    "Piranha Plant",
    "Joker",
    "Hero",
    "Banjo & Kazooie",
    "Terry",
    "Byleth",
    "Min Min",
    "Steve",
    "Sephiroth",
    "Pyra & Mythra",
    "Kazuya",
    "Sora"
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ChangeNotifierProvider<BannerModel>(
        create: (context) =>
            BannerModel(encodedBackground: null, character: null),
        child: ListView(
          padding: utils.MyUtils.setScreenPadding(context: context),
          children: [
            SmashBannerExpandable(
              title: "Background",
              expanded: BackgroundGeneratorForm(),
              richText: RichText(
                text: TextSpan(
                  text: "Background\n",
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                    TextSpan(
                      text:
                          "In this section, you are given the opportunity to set the parameters so the AI can generate a cool background"
                          " based on your preferences. It should be noted, each time you press the \'Generate Cool Background!\'"
                          " the AI generates a new background, so you can keep pressing the button and still obtain different but awesome results!\n\n",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: "Background Style\n",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    TextSpan(
                      text:
                          "For the moment, the AI can generate two styles of backgrounds: Vortex and Nebula.\n"
                          "The Vortex, as the name implies, is a design where lines and patterns emerge from a focal point.\n"
                          "The Nebula design is somewhat similar to flame designs. Lines and Patterns are more scattered around the image.\n\n",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: "Background Main Color\n",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    TextSpan(
                      text:
                          "The AI will generate the background's color around the main color you set."
                          " Cool trick: If you set the color to white, the AI can generate images using all colors."
                          " Depending on the grey shade, the AI will generate dimmer colors or brighter ones.\n\n",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: "Background Complexity\n",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    TextSpan(
                      text:
                          "There are 2 parameters: Background Design Complexity and Background Focal Point Positioning.\n"
                          "With the background Design Complexity parameter, you only have 3 options being: Simple, Moderate and Complex."
                          " Depending on the parameter you choose, the AI will vary the complexity of the background's design"
                          " (Note: As the complexity increases, it will take longer to generate your background).\n\n"
                          "With the Background Focal Point Positioning parameter, you can change where the \'center\' of the image is placed.\n"
                          "You have 9 available options: Top Left, Top Center, Top Right, Center Left,"
                          " Middle, Center Right, Bottom Left, Bottom Center and Botom Right.",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            utils.EmptySeparator(scale: 0.015),
            SmashBannerExpandable(
              title: "Character Selection",
              expanded: CharacterSelectorForm(
                charactersList: charactersList,
              ),
              richText: RichText(
                text: TextSpan(
                  text: "Character Selection\n",
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                    TextSpan(
                      text:
                          "Very straight forward. You choose the character you want to get featured in your banner and you can select the alt color you prefer.",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            utils.EmptySeparator(scale: 0.015),
            SmashBannerExpandable(
              title: "Social Media",
              expanded: SocialMediaForm(),
              richText: RichText(
                text: TextSpan(
                  text: "Social Media\n",
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                    TextSpan(
                      text:
                          "Here you can link up all the platforms you want! Make sure people get to know where to find you!\n"
                          "Don't worry if you don't have an account on every platform, only fill the ones you wish.",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            utils.EmptySeparator(scale: 0.015),
            SmashBannerExpandable(
              title: "Player Information",
              expanded: PlayerInformationForm(),
              richText: RichText(
                text: TextSpan(
                  text: "Player Information\n",
                  style: Theme.of(context).textTheme.headline3,
                  children: [
                    TextSpan(
                      text:
                          "Another very straight forward section. Here you can write your tag and your E-sports team or crew to show off!\n"
                          "Don't worry if you don't have an E-Sports team or Crew, your player tag is what matters!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            utils.EmptySeparator(scale: 0.015),
            AssembleSection(),
          ],
        ),
      ),
    );
  }
}
