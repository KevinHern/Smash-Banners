import 'package:flutter/material.dart';

class MyUtils {
  static EdgeInsetsGeometry setScreenPadding({required BuildContext context}) {
    final double width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return EdgeInsets.symmetric(
          horizontal: width * 0.2, vertical: width * 0.01);
    } else if (width >= 992) {
      return EdgeInsets.symmetric(
          horizontal: width * 0.1, vertical: width * 0.01);
    } else if (width >= 768) {
      return EdgeInsets.symmetric(
          horizontal: width * 0.075, vertical: width * 0.05);
    } else {
      return EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: width * 0.05);
    }
  }
}

class EmptySeparator extends StatelessWidget {
  final double scale;
  EmptySeparator({required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * this.scale,
    );
  }
}

class BooleanWrapper with ChangeNotifier {
  late bool _boolean;

  BooleanWrapper({required bool value}) {
    this._boolean = value;
  }

  bool get value => this._boolean;
  set value(bool newValue) {
    this._boolean = newValue;
    notifyListeners();
  }

  void invertValue() {
    this._boolean = !this._boolean;
    notifyListeners();
  }
}
