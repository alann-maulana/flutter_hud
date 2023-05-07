import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDPopupProgress extends StatefulWidget {
  static const String title = 'HUD Popup with Progress';

  const HUDPopupProgress({Key? key}) : super(key: key);

  @override
  State<HUDPopupProgress> createState() => _HUDPopupProgressState();
}

class _HUDPopupProgressState extends State<HUDPopupProgress> {
  String? resultPrimes;

  _reload() async {
    setState(() {
      resultPrimes = null;
    });
    final popup = PopupHUD(
      context,
      hud: HUD(
        label: 'Generating Primes',
        detailLabel: 'Initializing..',
      ),
    );

    popup.show();
    final number = await getPrimes(delayedSeconds: 1);
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      final value = i * 0.10;
      popup.setValue(value);
      popup.setDetailLabel('Progress ${(value * 100).toInt()}%..');
    }

    await Future.delayed(const Duration(milliseconds: 500));
    popup.dismiss();
    if (mounted) {
      setState(() {
        resultPrimes = number;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HUDPopupProgress.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (resultPrimes != null)
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
      floatingActionButton: FloatingActionButton(
        onPressed: _reload,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
