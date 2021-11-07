import 'package:flutter/material.dart';

// Extra Widgets
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Templates
import 'package:smash_banners/templates/form_assets.dart';
import 'package:smash_banners/templates/dialog_template.dart';

class CustomizeSlider extends StatelessWidget {
  final String title;
  final double min, max, initValue;
  final Function(double) onChanged;
  CustomizeSlider(
      {required this.title,
      required this.min,
      required this.max,
      required this.initValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormContainerSection(
      title: this.title,
      child: Card(
        child: Slider(
          min: this.min,
          max: this.max,
          value: this.initValue,
          onChanged: (value) => this.onChanged(value),
        ),
      ),
    );
  }
}

class CustomizeSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  CustomizeSwitch(
      {required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          this.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: Switch(
          onChanged: (value) => this.onChanged(value),
          value: this.value,
        ),
      ),
    );
  }
}

class CustomizeColor extends StatelessWidget {
  final int colorValue;
  final String title;
  final Function(int) onColorChanged;

  CustomizeColor({
    required this.colorValue,
    required this.title,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          color: Color(this.colorValue),
          height: 20,
          width: 20,
        ),
        title: Text(
          this.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: FormNormalButton(
          child: Icon(
            Icons.palette,
            color: Colors.white.withOpacity(0.9),
          ),
          onPressed: () {
            Color pickerColor = Color(this.colorValue);

            showDialog(
              context: context,
              builder: (context) {
                return AlertTemplate(
                  title: "Pick a Color!",
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerColor,
                      onColorChanged: (Color color) =>
                          this.onColorChanged(color.value),
                      showLabel: true,
                      pickerAreaHeightPercent: 0.8,
                      enableAlpha: false,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Center(
                        child: FormButton(
                          icon: Icons.close,
                          label: "Close",
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
