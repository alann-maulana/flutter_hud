import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDWidgetProgress extends StatefulWidget {
  static const String title = 'HUD with Progress';

  const HUDWidgetProgress({Key? key}) : super(key: key);

  @override
  State<HUDWidgetProgress> createState() => _HUDWidgetProgressState();
}

class _HUDWidgetProgressState extends State<HUDWidgetProgress> {
  bool showHUD = true;
  double? value;
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
      });
    }

    final number = await getPrimes(delayedSeconds: 1);
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          value = i * 0.10;
        });
      } else {
        break;
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        showHUD = false;
        resultPrimes = number;
        value = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetHUD(
      value: value,
      hud: HUD(
        label: 'Generating Primes',
        detailLabel: value == null
            ? 'Initializing..'
            : 'Progress ${(value! * 100).toInt()}%',
      ),
      builder: (context, child) => child!,
      showHUD: showHUD,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(HUDWidgetProgress.title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (!showHUD)
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
            ],
          ),
        ),
        floatingActionButton: !showHUD
            ? FloatingActionButton(
                onPressed: _reload,
                child: const Icon(Icons.refresh),
              )
            : null,
      ),
    );
  }
}
