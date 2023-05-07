import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDWithCancelable extends StatefulWidget {
  static const String title = 'HUD with Cancelable';

  const HUDWithCancelable({Key? key}) : super(key: key);

  @override
  State<HUDWithCancelable> createState() => _HUDWithCancelableState();
}

class _HUDWithCancelableState extends State<HUDWithCancelable> {
  bool showHUD = true;
  bool canceled = false;
  String? resultPrimes;

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
      builder: (context, child) => child!,
      showHUD: showHUD && !canceled,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(HUDWithCancelable.title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (!showHUD && !canceled)
                Text(
                  'The first 10 primes :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (resultPrimes != null)
                Text(
                  resultPrimes!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              if (!showHUD && canceled)
                Text(
                  'Process canceled',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
        ),
        floatingActionButton: !showHUD || canceled
            ? FloatingActionButton(
                onPressed: _reload,
                child: const Icon(Icons.refresh),
              )
            : null,
      ),
    );
  }
}
