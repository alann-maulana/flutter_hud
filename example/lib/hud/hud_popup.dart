import 'package:example/prime_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class HUDUsingPopup extends StatefulWidget {
  static const String title = 'HUD using PopUp';

  const HUDUsingPopup({Key? key}) : super(key: key);

  @override
  State<HUDUsingPopup> createState() => _HUDUsingPopupState();
}

class _HUDUsingPopupState extends State<HUDUsingPopup> {
  String? resultPrimes1;
  String? resultPrimes2;
  String? resultPrimes3;

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
        progressIndicator: CircularProgressIndicator.adaptive(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        labelStyle: Theme.of(context).textTheme.titleLarge,
        detailLabel: 'Initializing...',
        detailLabelStyle: Theme.of(context).textTheme.titleSmall,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        padding: const EdgeInsets.all(16),
      ),
    );

    popup.show();
    await Future.delayed(const Duration(seconds: 2));
    final primes1 = primesMap().take(10).join(', ');

    popup.setDetailLabel('Progress 33%...');
    await Future.delayed(const Duration(seconds: 2));
    final primes2 = primesMap().take(20).skip(10).join(', ');

    popup.setDetailLabel('Progress 66%...');
    await Future.delayed(const Duration(seconds: 2));
    final primes3 = primesMap().take(30).skip(20).join(', ');

    popup.setDetailLabel('Done 100%...');
    await Future.delayed(const Duration(milliseconds: 500));

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
        title: const Text(HUDUsingPopup.title),
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
