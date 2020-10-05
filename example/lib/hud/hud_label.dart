import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDWithLabel extends StatelessWidget {
  static const String title = 'HUD with Label';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getPrimes(),
      builder: (context, snapshot) {
        return WidgetHUD(
          hud: HUD(label: 'Generating Primes'),
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (snapshot.hasData)
                    Text(
                      'The first 10 primes :',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  if (snapshot.hasData)
                    Text(
                      snapshot.data,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                ],
              ),
            ),
          ),
          showHUD: !snapshot.hasData,
        );
      },
    );
  }
}
