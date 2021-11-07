// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/utilities/utils.dart' as utils;

// Models
import 'package:smash_banners/models/banner_model.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';

class PlayerInformationInput extends StatelessWidget {
  final String asset, label;
  final String? initialValue;
  final Function(String?) onChanged;

  PlayerInformationInput(
      {required this.label,
      required this.asset,
      @required this.initialValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Image.asset(
          "assets/" + this.asset + ".png",
          scale: 2,
        ),
        labelText: this.label,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      initialValue: (initialValue == null) ? "" : initialValue,
      onChanged: (value) => this.onChanged(value.length == 0 ? null : value),
    );
  }
}

class PlayerInformationForm extends StatelessWidget {
  final characterFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormCard(
      formKey: characterFormKey,
      child: Column(
        children: [
          Text(
            "Player Information",
            style: Theme.of(context).textTheme.headline1,
          ),
          utils.EmptySeparator(
            scale: 0.02,
          ),
          Consumer<BannerModel>(
            builder: (context, bannerModel, __) {
              return Column(
                children: [
                  PlayerInformationInput(
                    label: 'E-Sports Team/Crew',
                    asset: 'joystick',
                    initialValue: bannerModel.eSportsTeam,
                    onChanged: (value) =>
                        bannerModel.setESportsTeam(eSportsTeam: value),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  PlayerInformationInput(
                    label: 'Player Tag',
                    asset: 'smash_bros',
                    initialValue: bannerModel.playerTag,
                    onChanged: (value) =>
                        bannerModel.setPlayerTag(playerTag: value),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
