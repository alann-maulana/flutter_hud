import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDWithLabelDetail extends StatelessWidget {
  static const String title = 'HUD with Label and Detail';

  const HUDWithLabelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getPrimes(),
      builder: (context, snapshot) {
        return WidgetHUD(
          hud: HUD(
            label: 'Generating Primes',
            detailLabel: 'for the first 10',
          ),
          builder: (context, child) => child!,
          showHUD: !snapshot.hasData,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (snapshot.hasData)
                    Text(
                      'The first 10 primes :',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  if (snapshot.hasData)
                    Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
