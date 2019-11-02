import 'package:example/hud/hud_cancelable.dart';
import 'package:example/hud/hud_default.dart';
import 'package:example/hud/hud_label.dart';
import 'package:example/hud/hud_label_detail.dart';
import 'package:example/hud/hud_popup.dart';
import 'package:example/hud/hud_popup_cancelable.dart';
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
        children: ListTile.divideTiles(
          context: context,
          tiles: <Widget>[
            TileGroup('HUD WIDGET'),
            TileItem(
              label: HUDDefault.title,
              description: 'Show default centered activity indicator',
              builder: (context) => HUDDefault(),
            ),
            TileItem(
              label: HUDWithLabel.title,
              description: '"${HUDDefault.title}" with a label below',
              builder: (context) => HUDWithLabel(),
            ),
            TileItem(
              label: HUDWithLabelDetail.title,
              description:
                  '"${HUDDefault.title}" with label and detailed label below',
              builder: (context) => HUDWithLabelDetail(),
            ),
            TileItem(
              label: HUDWithCancelable.title,
              description:
                  '"${HUDWithLabelDetail.title}" with cancelable button',
              builder: (context) => HUDWithCancelable(),
            ),
            TileGroup('HUD POPUP'),
            TileItem(
              label: HUDUsingPopup.title,
              description: 'Show HUD using `ModalRoute`',
              builder: (context) => HUDUsingPopup(),
            ),
            TileItem(
              label: HUDUsingPopupCancelable.title,
              description: '"${HUDUsingPopup.title}" with cancelable options',
              builder: (context) => HUDUsingPopupCancelable(),
            ),
          ].map((t) => t),
        ).toList(),
      ),
    );
  }
}

class TileGroup extends StatelessWidget {
  TileGroup(this.header);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[100],
      child: ListTile(
        title: Text(
          header.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class TileItem extends StatelessWidget {
  TileItem({
    this.label,
    this.description,
    this.builder,
  });

  final String label;
  final String description;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: builder),
      ),
      title: Text(label),
      subtitle: Text(description),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
