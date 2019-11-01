import 'package:example/hud/hud_cancelable.dart';
import 'package:example/hud/hud_default.dart';
import 'package:example/hud/hud_label.dart';
import 'package:example/hud/hud_label_detail.dart';
import 'package:example/hud/hud_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HUDList(),
    );
  }
}

class HUDList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HUD'),
      ),
      body: ListView(
        children: <Widget>[
          ButtonItem(
            label: HUDDefault.title,
            builder: (context) => HUDDefault(),
          ),
          ButtonItem(
            label: HUDWithLabel.title,
            builder: (context) => HUDWithLabel(),
          ),
          ButtonItem(
            label: HUDWithLabelDetail.title,
            builder: (context) => HUDWithLabelDetail(),
          ),
          ButtonItem(
            label: HUDWithCancelable.title,
            builder: (context) => HUDWithCancelable(),
          ),
          ButtonItem(
            label: HUDUsingPopup.title,
            builder: (context) => HUDUsingPopup(),
          ),
        ],
      ),
    );
  }
}

class ButtonItem extends StatelessWidget {
  ButtonItem({
    this.label,
    this.builder,
  });

  final String label;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RaisedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: builder),
        ),
        child: Text(label),
      ),
    );
  }
}
