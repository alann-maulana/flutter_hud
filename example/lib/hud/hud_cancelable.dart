import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDWithCancelable extends StatefulWidget {
  static const String title = 'HUD with Cancelable';

  @override
  _HUDWithCancelableState createState() => _HUDWithCancelableState();
}

class _HUDWithCancelableState extends State<HUDWithCancelable> {
  bool showHUD = true;
  bool canceled = false;
  String resultPrimes;

  @override
  void initState() {
    super.initState();

    _reload();
  }

  _reload() async {
    if (!showHUD) {
      setState(() {
        showHUD = true;
        canceled = false;
      });
    }

    final number = await getPrimes(delayedSeconds: 5);
    if (mounted && !canceled) {
      setState(() {
        showHUD = false;
        resultPrimes = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetHUD(
      hud: HUD(
        label: 'Generating Primes',
        detailLabel: 'Tap the modal for canceling',
      ),
      onCancel: () {
        setState(() {
          canceled = true;
          showHUD = false;
          resultPrimes = null;
        });
      },
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(HUDWithCancelable.title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (!showHUD && !canceled)
                Text(
                  'The first 10 primes :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              if (!showHUD && !canceled)
                Text(
                  resultPrimes,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              if (!showHUD && canceled)
                Text(
                  'Process canceled',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1,
                ),
            ],
          ),
        ),
        floatingActionButton: !showHUD || canceled
            ? FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: _reload,
              )
            : null,
      ),
      showHUD: showHUD && !canceled,
    );
  }
}
