# Flutter HUD

[![Pub](https://img.shields.io/pub/v/flutter_hud)](https://pub.dev/packages/flutter_hud) [![Build Status](https://travis-ci.org/eyro-labs/flutter_hud.svg?branch=master)](https://travis-ci.org/eyro-labs/flutter_hud) [![Coverage Status](https://coveralls.io/repos/github/eyro-labs/flutter_hud/badge.svg?branch=develop)](https://coveralls.io/github/eyro-labs/flutter_hud?branch=develop) [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Feyro-labs%2Fflutter_hud.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Feyro-labs%2Fflutter_hud?ref=badge_shield)  

A clean and lightweight progress HUD to show a running asynchronous task for Flutter.

Features:
* Widget HUD
* PopUp HUD

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
  flutter_parse: any
```

## Import Library
```dart   
import 'package:flutter_hud/flutter_hud.dart';
```

## Widget HUD
Simple use of progress Widget HUD with `FutureBuilder`: 
1. Default HUD
```dart
FutureBuilder<String>(
  future: executeHttpRequest(),
  builder: (context, snapshot) {
    return WidgetHUD(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Default HUD'),
        ),
        body: Center(
          child: Text(snapshot.hasData ? snapshot.data : ''),
        ),
      ),
      showHUD: !snapshot.hasData,
    );
  },
);
```

2. HUD with Label
```dart
FutureBuilder<String>(
  future: executeHttpRequest(),
  builder: (context, snapshot) {
    return WidgetHUD(
      hud: HUD(label: 'Executing Http Request'),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('HUD with Label'),
        ),
        body: Center(
          child: Text(snapshot.hasData ? snapshot.data : ''),
        ),
      ),
      showHUD: !snapshot.hasData,
    );
  },
);
```

3. HUD with Label and Detail Label
```dart
FutureBuilder<String>(
  future: executeHttpRequest(),
  builder: (context, snapshot) {
    return WidgetHUD(
      hud: HUD(
        label: 'Executing Http Request', 
        detailLabel: 'Please Wait a Moment',
      ),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('HUD with Label and Detail'),
        ),
        body: Center(
          child: Text(snapshot.hasData ? snapshot.data : ''),
        ),
      ),
      showHUD: !snapshot.hasData,
    );
  },
);
```

## PopUp HUD
Displaying progress HUD using `ModalRoute` :
```dart
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
              style: Theme.of(context).textTheme.title,
            ),
          if (resultPrimes1 != null)
            Text(
              resultPrimes1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
            ),
          if (resultPrimes2 != null)
            Text(
              'The second 10 primes :',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
          if (resultPrimes2 != null)
            Text(
              resultPrimes2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
            ),
          if (resultPrimes3 != null)
            Text(
              'The third 10 primes :',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
          if (resultPrimes3 != null)
            Text(
              resultPrimes3,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
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
```

Please see folder `example\lib` to view a complete example about using `flutter_hud`.

# Author

Flutter HUD plugin is developed by Eyro Labs. You can contact us at <me@eyro.co.id>.

## License

MIT License
- [See LICENSE](https://github.com/eyro-labs/flutter_hud/blob/master/LICENSE)