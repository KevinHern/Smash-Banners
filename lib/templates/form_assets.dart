import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Widget child;
  FormCard({required this.formKey, required this.child});
  FormCardState createState() =>
      FormCardState(formKey: formKey, child: this.child);
}

class FormCardState extends State<FormCard> {
  final GlobalKey<FormState> formKey;
  final Widget child;
  FormCardState({required this.formKey, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: this.formKey,
          child: this.child,
        ),
      ),
    );
  }
}

class FormContainerSection extends StatelessWidget {
  final String title;
  final Widget child;
  FormContainerSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: this.title,
          labelStyle: TextStyle(
            fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 0.0),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: this.child,
      ),
    );
  }
}

class FormContainer extends StatelessWidget {
  final Widget child;
  FormContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0,
          color: Theme.of(context).accentColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: this.child,
    );
  }
}

class FormButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;

  FormButton(
      {required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shadowColor: Colors.black54,
      ),
      icon: Icon(
        this.icon,
        color: Colors.white.withOpacity(0.90),
      ),
      label: Text(
        this.label,
        style: TextStyle(
          fontFamily: Theme.of(context).textTheme.subtitle1!.fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
      onPressed: () => this.onPressed(),
    );
  }
}

class FormNormalButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  FormNormalButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        shadowColor: Colors.black54,
      ),
      child: this.child,
      onPressed: () => this.onPressed(),
    );
  }
}
