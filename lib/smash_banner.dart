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
            BackgroundGeneratorForm(),
            utils.EmptySeparator(scale: 0.015),
            CharacterSelectorForm(),
            utils.EmptySeparator(scale: 0.015),
            SocialMediaForm(),
            utils.EmptySeparator(scale: 0.015),
            PlayerInformationForm(),
            utils.EmptySeparator(scale: 0.015),
            AssembleSection(),
          ],
        ),
      ),
    );
  }
}
