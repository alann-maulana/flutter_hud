import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDUsingPopup extends StatefulWidget {
  static const String title = 'HUD using PopUp';

  @override
  _HUDUsingPopupState createState() => _HUDUsingPopupState();
}

class _HUDUsingPopupState extends State<HUDUsingPopup> {
  String resultPrimes1;
  String resultPrimes2;
  String resultPrimes3;

  _reload() async {
    setState(() {
      resultPrimes1 = null;
      resultPrimes2 = null;
      resultPrimes3 = null;
    });
    final popup = PopupHUD(
      context,
      hud: HUD(
        label: 'Generating Primes',
        detailLabel: 'Initializing...',
      ),
    );

    popup.show();
    await Future.delayed(Duration(seconds: 2));
    final primes1 = primesMap().take(10).join(', ');

    popup.setDetailLabel('Progress 33%...');
    await Future.delayed(Duration(seconds: 2));
    final primes2 = primesMap().take(20).skip(10).join(', ');

    popup.setDetailLabel('Progress 66%...');
    await Future.delayed(Duration(seconds: 2));
    final primes3 = primesMap().take(30).skip(20).join(', ');

    popup.setDetailLabel('Done 100%...');
    await Future.delayed(Duration(milliseconds: 500));

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
        title: Text(HUDUsingPopup.title),
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
