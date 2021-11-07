// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/utilities/utils.dart' as utils;

// Extra Widgets
import 'package:dropdown_search/dropdown_search.dart';

// Models
import 'package:smash_banners/models/banner_model.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';

class SocialMediaPlatformForm extends StatelessWidget {
  final String asset;
  final String label;
  final int socialMediaOption;

  SocialMediaPlatformForm(
      {required this.label,
      required this.asset,
      required this.socialMediaOption});

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerModel>(
      builder: (context, bannerModel, __) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Image.asset(
              "assets/" + this.asset + ".png",
              scale: 2,
            ),
            labelText: this.label,
          ),
          style: Theme.of(context).textTheme.bodyText1,
          initialValue: (bannerModel.socialMedia[socialMediaOption] == null)
              ? ""
              : bannerModel.socialMedia[socialMediaOption],
          onChanged: (value) => bannerModel.setSocialMedia(
              index: socialMediaOption,
              socialMedia: (value.length == 0) ? null : value),
        );
      },
    );
  }
}

class SocialMediaForm extends StatelessWidget {
  final socialMediaKeyForm = GlobalKey<FormState>();
  static const spacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      formKey: this.socialMediaKeyForm,
      child: Column(
        children: [
          Text(
            "Social Media",
            style: Theme.of(context).textTheme.headline1,
          ),
          utils.EmptySeparator(
            scale: 0.02,
          ),
          FormContainerSection(
            title: "Social Media Platforms",
            child: Column(
              children: [
                SocialMediaPlatformForm(
                  label: 'Twitch Channel',
                  asset: 'twitch',
                  socialMediaOption: 0,
                ),
                const SizedBox(
                  height: spacing,
                ),
                SocialMediaPlatformForm(
                  label: 'Twitter Handle',
                  asset: 'twitter',
                  socialMediaOption: 1,
                ),
                const SizedBox(
                  height: spacing,
                ),
                SocialMediaPlatformForm(
                  label: 'Youtube Channel',
                  asset: 'youtube',
                  socialMediaOption: 2,
                ),
                const SizedBox(
                  height: spacing,
                ),
                SocialMediaPlatformForm(
                  label: 'Instagram User',
                  asset: 'instagram',
                  socialMediaOption: 3,
                ),
                const SizedBox(
                  height: spacing,
                ),
                SocialMediaPlatformForm(
                  label: 'Discord User',
                  asset: 'discord',
                  socialMediaOption: 4,
                ),
              ],
            ),
          ),
          utils.EmptySeparator(
            scale: 0.02,
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            maxHeight: 470,
            items: ["Font 1", "Font 2"],
            dropdownSearchDecoration: InputDecoration(
              labelText: "Font to use",
              hintText: "Font to user",
              hintStyle: TextStyle(
                fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
                fontWeight: FontWeight.bold,
              ),
              labelStyle: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            dropdownSearchBaseStyle: TextStyle(
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            ),
            showSearchBox: true,
            onChanged: (value) => {},
            showSelectedItems: true,
            validator: (String? item) {
              if (item == null)
                return "Required field";
              else
                return null;
            },
          ),
        ],
      ),
    );
  }
}
