// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_banners/utilities/utils.dart' as utils;

// Extra Widgets
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Models
import 'package:smash_banners/models/banner_model.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';
import 'package:smash_banners/templates/dialog_template.dart';

// Backend
import 'package:http/http.dart' as http;
import 'dart:convert';

enum RGB { R, G, B }

class RGBScaleSelector extends StatelessWidget {
  final RGB rgb;
  final double width;
  RGBScaleSelector({
    required this.rgb,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (this.rgb == RGB.R)
              ? "R"
              : (this.rgb == RGB.G)
                  ? "G"
                  : "B",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 10),
        Container(
          width: this.width,
          child: Consumer<ValueNotifier<int>>(
            builder: (context, colorValue, __) {
              return SpinBox(
                min: 0,
                max: 255,
                value: (this.rgb == RGB.R)
                    ? ((colorValue.value & 0x00FF0000) >> 16) as double
                    : (this.rgb == RGB.G)
                        ? ((colorValue.value & 0x0000FF00) >> 8) as double
                        : ((colorValue.value & 0x000000FF)) as double,
                onChanged: (value) {
                  switch (this.rgb) {
                    case RGB.R:
                      int temp = 0xFF00FFFF & colorValue.value;
                      colorValue.value = temp | ((value as int) << 16);
                      break;
                    case RGB.G:
                      int temp = 0xFFFF00FF & colorValue.value;
                      colorValue.value = temp | ((value as int) << 8);
                      break;
                    case RGB.B:
                      int temp = 0xFFFFFF00 & colorValue.value;
                      colorValue.value = temp | (value as int);
                      break;
                    default:
                      throw Exception("Unreachable state");
                  }
                },
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

class BackgroundGeneratorForm extends StatelessWidget {
  final backgroundKeyForm = GlobalKey<FormState>();
  final List<String> formParameters = ["", "S", "TL"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FormCard(
          formKey: this.backgroundKeyForm,
          child: ChangeNotifierProvider<ValueNotifier<int>>(
            create: (context) => ValueNotifier<int>(0xFFAAAAAA),
            child: Column(
              children: [
                Text(
                  "Background",
                  style: Theme.of(context).textTheme.headline1,
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                DropdownSearch<String>(
                  mode: Mode.MENU,
                  maxHeight: 100,
                  items: ["Vortex", "Nebula"],
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Background Style",
                    hintText: "Background Style",
                    hintStyle: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle1!.fontFamily,
                    ),
                    labelStyle: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.subtitle1!.fontFamily,
                    ),
                    icon: Icon(
                      Icons.image,
                      size: 40,
                    ),
                  ),
                  dropdownSearchBaseStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1!.fontFamily,
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      switch (value) {
                        case "Vortex":
                          this.formParameters[0] = "V";
                          break;
                        case "Nebula":
                          this.formParameters[0] = "N";
                          break;
                        default:
                          throw Exception(
                              "Unreachable option in Background Style");
                      }
                    }
                    ;
                  },
                  showSelectedItems: true,
                  validator: (String? item) {
                    if (item == null)
                      return "Required field";
                    else
                      return null;
                  },
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                FormContainerSection(
                  title: "Background Main Color",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            RGBScaleSelector(rgb: RGB.R),
                            utils.EmptySeparator(scale: 0.01),
                            RGBScaleSelector(rgb: RGB.G),
                            utils.EmptySeparator(scale: 0.01),
                            RGBScaleSelector(rgb: RGB.B),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Consumer<ValueNotifier<int>>(
                              builder: (context, color, __) {
                                return Container(
                                  color: Color(color.value),
                                  width: 125,
                                  height: 125,
                                );
                              },
                            ),
                            utils.EmptySeparator(
                              scale: 0.01,
                            ),
                            Consumer<ValueNotifier<int>>(
                              builder: (context, colorValue, __) {
                                return FormButton(
                                  label: "Pick Color",
                                  icon: Icons.palette,
                                  onPressed: () {
                                    Color pickerColor = Color(colorValue.value);

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertTemplate(
                                          title: "Pick a Color!",
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor: pickerColor,
                                              onColorChanged: (Color color) =>
                                                  colorValue.value =
                                                      color.value,
                                              showLabel: true,
                                              pickerAreaHeightPercent: 0.8,
                                              enableAlpha: false,
                                            ),
                                          ),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: Center(
                                                child: FormButton(
                                                  icon: Icons.close,
                                                  label: "Close",
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                FormContainerSection(
                  title: "Background Complexity",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 150,
                        child: WheelChooser(
                          onValueChanged: (value) {
                            switch (value) {
                              case "Simple":
                                this.formParameters[1] = "S";
                                break;
                              case "Moderate":
                                this.formParameters[1] = "M";
                                break;
                              case "Complex":
                                this.formParameters[1] = "C";
                                break;
                              default:
                                throw Exception(
                                    "Unreachable option for Background Complexity");
                            }
                          },
                          datas: ["Simple", "Moderate", "Complex"],
                          horizontal: false,
                          selectTextStyle: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .fontFamily,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          unSelectTextStyle: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 150,
                        child: WheelChooser(
                          onValueChanged: (value) {
                            switch (value) {
                              case "T. Left":
                                this.formParameters[2] = "TL";
                                break;
                              case "T. Center":
                                this.formParameters[2] = "TC";
                                break;
                              case "T. Right":
                                this.formParameters[2] = "TR";
                                break;
                              case "C. Left":
                                this.formParameters[2] = "CL";
                                break;
                              case "Middle":
                                this.formParameters[2] = "M";
                                break;
                              case "C. Right":
                                this.formParameters[2] = "CR";
                                break;
                              case "B. Left":
                                this.formParameters[2] = "BL";
                                break;
                              case "B. Center":
                                this.formParameters[2] = "BC";
                                break;
                              case "B. Right":
                                this.formParameters[2] = "BR";
                                break;
                              default:
                                throw Exception("Unreachable Wheel 2 Option");
                            }
                          },
                          datas: [
                            "T. Left",
                            "T. Center",
                            "T. Right",
                            "C. Left",
                            "Middle",
                            "C. Right",
                            "B. Left",
                            "B. Center",
                            "B. Right",
                          ],
                          horizontal: false,
                          selectTextStyle: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .fontFamily,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          unSelectTextStyle: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontFamily,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                utils.EmptySeparator(
                  scale: 0.02,
                ),
                Consumer<ValueNotifier<int>>(
                  builder: (context, colorValue, __) {
                    return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shadowColor: Colors.black54,
                      ),
                      label: Text(
                        "Generate Cool Background!",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.subtitle1!.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontSize:
                              Theme.of(context).textTheme.subtitle1!.fontSize,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      icon: Icon(
                        Icons.check,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      onPressed: () async {
                        if (this.backgroundKeyForm.currentState!.validate()) {
                          // Show loader
                          Provider.of<BannerModel>(context, listen: false)
                              .setFetchingEncodedBackground(status: true);
                          Provider.of<BannerModel>(context, listen: false)
                              .clearEncodedBackground(update: true);

                          // Do request
                          http.Response response = await http.post(
                            Uri.parse(
                              "http://067f-34-132-89-37.ngrok.io/background",
                            ),
                            body: {
                              "style": this.formParameters[0],
                              "complexity": this.formParameters[1],
                              "side": this.formParameters[2],
                              "red": ((colorValue.value & 0x00FF0000) >> 16)
                                  .toString(),
                              "green": ((colorValue.value & 0x0000FF00) >> 8)
                                  .toString(),
                              "blue":
                                  (colorValue.value & 0x000000FF).toString(),
                            },
                          );

                          Provider.of<BannerModel>(context, listen: false)
                              .setFetchingEncodedBackground(status: false);

                          // Check Status
                          if (response.statusCode == 200) {
                            // Parsear body
                            Map<String, dynamic> recvJson =
                                JsonDecoder().convert(response.body);

                            // Clearing previous images
                            Provider.of<BannerModel>(context, listen: false)
                                .clearEncodedBackground();

                            Provider.of<BannerModel>(context, listen: false)
                                .setEncodedBackground(
                              encodedBackground: recvJson["background"],
                            );

                            Provider.of<BannerModel>(context, listen: false)
                                .update();
                          } else {
                            // Reportar error
                            DialogTemplate.showMessage(
                                context: context,
                                message:
                                    "An error occurred when retreiving a background, try again.");
                          }
                        }
                      },
                    );
                  },
                ),
                Consumer<BannerModel>(
                  builder: (context, bannerModel, __) {
                    if (bannerModel.fetchingEncodedBackground)
                      return Column(
                        children: [
                          utils.EmptySeparator(
                            scale: 0.02,
                          ),
                          Container(
                            height: 256,
                            width: 512,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Text(
                                    "Creating background...",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    else
                      return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Image.asset(
            'assets/info.png',
            width: 60,
            height: 60,
          ),
          elevation: 2.0,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
