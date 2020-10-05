import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDUsingPopupCancelable extends StatefulWidget {
  static const String title = 'HUD PopUp with Cancelable';

  @override
  _HUDUsingPopupCancelableState createState() =>
      _HUDUsingPopupCancelableState();
}

class _HUDUsingPopupCancelableState extends State<HUDUsingPopupCancelable> {
  String resultPrimes1;
  String resultPrimes2;
  String resultPrimes3;

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
    await Future.delayed(Duration(seconds: 2));
    if (canceled) return;
    final primes1 = primesMap().take(10).join(', ');

    popup.setDetailLabel('Progress 33%...');
    if (canceled) return;
    await Future.delayed(Duration(seconds: 2));
    if (canceled) return;
    final primes2 = primesMap().take(20).skip(10).join(', ');

    popup.setDetailLabel('Progress 66%...');
    if (canceled) return;
    await Future.delayed(Duration(seconds: 2));
    if (canceled) return;
    final primes3 = primesMap().take(30).skip(20).join(', ');

    popup.setDetailLabel('Done 100%...');
    if (canceled) return;
    await Future.delayed(Duration(milliseconds: 500));
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HUDUsingPopupCancelable.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (resultPrimes1 != null)
              Text(
                'The first 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            if (resultPrimes1 != null)
              Text(
                resultPrimes1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            if (resultPrimes2 != null)
              Text(
                'The second 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            if (resultPrimes2 != null)
              Text(
                resultPrimes2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            if (resultPrimes3 != null)
              Text(
                'The third 10 primes :',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            if (resultPrimes3 != null)
              Text(
                resultPrimes3,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            if (canceled)
              Text(
                'Process canceled',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _reload,
      ),
    );
  }
}
