import 'package:example/hud/hud_cancelable.dart';
import 'package:example/hud/hud_default.dart';
import 'package:example/hud/hud_label.dart';
import 'package:example/hud/hud_label_detail.dart';
import 'package:example/hud/hud_popup.dart';
import 'package:example/hud/hud_popup_cancelable.dart';
import 'package:example/hud/hud_popup_progress.dart';
import 'package:example/hud/hud_progress.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HUDList(),
    );
  }
}

class HUDList extends StatelessWidget {
  const HUDList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter HUD'),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: <Widget>[
            const TileGroup('HUD WIDGET'),
            TileItem(
              label: HUDDefault.title,
              description: 'Show default centered activity indicator',
              builder: (context) => const HUDDefault(),
            ),
            TileItem(
              label: HUDWithLabel.title,
              description: '"${HUDDefault.title}" with a label below',
              builder: (context) => const HUDWithLabel(),
            ),
            TileItem(
              label: HUDWithLabelDetail.title,
              description:
                  '"${HUDDefault.title}" with label and detailed label below',
              builder: (context) => const HUDWithLabelDetail(),
            ),
            TileItem(
              label: HUDWithCancelable.title,
              description:
                  '"${HUDWithLabelDetail.title}" with cancelable button',
              builder: (context) => const HUDWithCancelable(),
            ),
            TileItem(
              label: HUDWidgetProgress.title,
              description: '"${HUDWithLabelDetail.title}" with progress',
              builder: (context) => const HUDWidgetProgress(),
            ),
            const TileGroup('HUD POPUP'),
            TileItem(
              label: HUDUsingPopup.title,
              description: 'Show HUD using `ModalRoute`',
              builder: (context) => const HUDUsingPopup(),
            ),
            TileItem(
              label: HUDUsingPopupCancelable.title,
              description: '"${HUDUsingPopup.title}" with cancelable options',
              builder: (context) => const HUDUsingPopupCancelable(),
            ),
            TileItem(
              label: HUDPopupProgress.title,
              description: '"${HUDUsingPopup.title}" with progress',
              builder: (context) => const HUDPopupProgress(),
            ),
          ].map((t) => t),
        ).toList(),
      ),
    );
  }
}

class TileGroup extends StatelessWidget {
  const TileGroup(this.header, {Key? key}) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[100],
      child: ListTile(
        title: Text(
          header.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class TileItem extends StatelessWidget {
  const TileItem({
    Key? key,
    required this.label,
    required this.description,
    required this.builder,
  }) : super(key: key);

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
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
