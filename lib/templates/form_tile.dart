import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dialog_template.dart';

class TextInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  TextInputField(
      {required this.icon, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: this.label,
        icon: Icon(this.icon),
        labelText: this.label,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      controller: this.controller,
      readOnly: true,
      validator: (String? value) {
        if (value == null)
          return null;
        else
          return (value.trim().isEmpty) ? 'Select an option' : null;
      },
    );
  }
}

class NumberInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  NumberInputField(
      {required this.icon, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: this.label,
        icon: Icon(this.icon),
        labelText: this.label,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      controller: this.controller,
      readOnly: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null)
          return null;
        else
          return (value.trim().isEmpty) ? 'Select an option' : null;
      },
    );
  }
}

class FormTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  FormTile({required this.icon, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: TextFormField(
        decoration: InputDecoration(
          hintText: this.label,
          icon: Icon(this.icon),
          labelText: this.label,
        ),
        style: Theme.of(context).textTheme.bodyText1,
        controller: this.controller,
        readOnly: true,
        validator: (String? value) {
          if (value == null)
            return null;
          else
            return (value.trim().isEmpty) ? 'Select an option' : null;
        },
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          shadowColor: Colors.black26,
        ),
        child: Icon(Icons.edit),
        onPressed: () => DialogTemplate.showSelectOptions(
          context: context,
          title: 'Options',
          options: const [0, 1, 2],
          captions: const ['tanh', 'relu', 'sigmoid'],
          aftermath: (index) => {},
        ),
      ),
    );
  }
}
