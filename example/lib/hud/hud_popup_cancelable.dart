import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDUsingPopupCancelable extends StatefulWidget {
  static const String title = 'HUD PopUp with Cancelable';

  const HUDUsingPopupCancelable({Key? key}) : super(key: key);

  @override
  State<HUDUsingPopupCancelable> createState() =>
      _HUDUsingPopupCancelableState();
}

class _HUDUsingPopupCancelableState extends State<HUDUsingPopupCancelable> {
  String? resultPrimes1;
  String? resultPrimes2;
  String? resultPrimes3;

  bool canceled = false;

  _reload() async {
    setState(() {
      resultPrimes1 = null;
      resultPrimes2 = null;
      resultPrimes3 = null;

      if (canceled) {
        canceled = false;
      }
    });
    final popup = PopupHUD(
      context,
      hud: HUD(
        label: 'Generating Primes',
        detailLabel: 'Initializing...',
      ),
      onCancel: () {
        setState(() {
          canceled = true;
        });
      },
    );

    popup.show();
    if (canceled) return;
    await Future.delayed(const Duration(seconds: 2));
    if (canceled) return;
    final primes1 = primesMap().take(10).join(', ');

    popup.setDetailLabel('Progress 33%...');
    if (canceled) return;
    await Future.delayed(const Duration(seconds: 2));
    if (canceled) return;
    final primes2 = primesMap().take(20).skip(10).join(', ');

    popup.setDetailLabel('Progress 66%...');
    if (canceled) return;
    await Future.delayed(const Duration(seconds: 2));
    if (canceled) return;
    final primes3 = primesMap().take(30).skip(20).join(', ');

    popup.setDetailLabel('Done 100%...');
    if (canceled) return;
    await Future.delayed(const Duration(milliseconds: 500));
    if (canceled) return;

    popup.dismiss();
    if (mounted) {
      setState(() {
        resultPrimes1 = primes1;
        resultPrimes2 = primes2;
        resultPrimes3 = primes3;
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
        title: const Text(HUDUsingPopupCancelable.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (resultPrimes1 != null)
              Text(
                'The first 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (resultPrimes1 != null)
              Text(
                resultPrimes1!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            if (resultPrimes2 != null)
              Text(
                'The second 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (resultPrimes2 != null)
              Text(
                resultPrimes2!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            if (resultPrimes3 != null)
              Text(
                'The third 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (resultPrimes3 != null)
              Text(
                resultPrimes3!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            if (canceled)
              Text(
                'Process canceled',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
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
