# Flutter HUD

[![Pub](https://img.shields.io/pub/v/flutter_hud)](https://pub.dev/packages/flutter_hud) [![Build](https://github.com/alann-maulana/flutter_hud/workflows/Flutter%20CI/badge.svg)](https://github.com/alann-maulana/flutter_hud/actions?query=workflow%3A%22Flutter+CI%22) [![Coverage Status](https://coveralls.io/repos/github/alann-maulana/flutter_hud/badge.svg?branch=master)](https://coveralls.io/github/alann-maulana/flutter_hud?branch=master) [![GitHub](https://img.shields.io/github/license/alann-maulana/flutter_hud?color=2196F3)](https://github.com/alann-maulana/flutter_hud/blob/master/LICENSE) [![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Falann-maulana%2Fflutter_hud.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Falann-maulana%2Fflutter_hud?ref=badge_shield)

A clean and lightweight progress HUD to show a running asynchronous task for Flutter.

Features:
* Widget HUD
* PopUp HUD

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
  flutter_hud: any
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
      builder: (context, child) => Scaffold(
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
      builder: (context, child) => Scaffold(
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
      builder: (context, child) => Scaffold(
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

> How about adding some progress to it?
```dart
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
  await Future.delayed(Duration(milliseconds: 500));
  final value = i * 0.10;
  popup.setValue(value);
  popup.setDetailLabel('Progress ${(value * 100).toInt()}%..');
}

await Future.delayed(Duration(milliseconds: 500));
popup.dismiss();
```

Please see folder [example/lib](https://github.com/alann-maulana/flutter_hud/tree/master/example/lib/hud) to view a complete example about using `flutter_hud`.

## Widget HUD Demo

| [Widget HUD][1.hud-default]            | [Widget HUD with Label][2.hud-with-label]    | [Widget HUD with Label and Detail][3.hud-with-label-detail]      |
| -------------------------------------- | -------------------------------------------- | ---------------------------------------------------------------- |
| ![HUD Default][1.hud-default.gif]      | ![HUD with Label][2.hud-with-label.gif]      | ![HUD Default][3.hud-with-label-detail.gif]                      |

| [Widget HUD with Cancelable][4.hud-with-cancelable]  | [Widget HUD with Progress][7.hud-progress]  |   |
| ---------------------------------------------------- | ------------------------------------------- | - |
| ![HUD with Cancelable][4.hud-with-cancelable.gif]    | ![HUD with Progress][7.hud-progress.gif]    |   |

## Widget HUD Popup

| [Popup HUD][5.hud-popup]               | [Popup HUD with Cancelable][6.hud-popup-cancelable]      | [Popup HUD with Progress][8.hud-popup-progress] |
| -------------------------------------- | -------------------------------------------------------- | ----------------------------------------------- |
| ![HUD Popup Default][5.hud-popup.gif]  | ![HUD Popup with Cancelable][6.hud-popup-cancelable.gif] | ![HUD Popup Progress][8.hud-popup-progress.gif] |

## Author

Flutter HUD plugin is developed by Alann Maulana. You can contact us me <mas@alan.my.id>.

[1.hud-default.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/1.hud-default.gif "HUD Default"
[2.hud-with-label.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/2.hud-with-label.gif "HUD with Label"
[3.hud-with-label-detail.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/3.hud-with-label-detail.gif "HUD with Label and Detail"
[4.hud-with-cancelable.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/4.hud-with-cancelable.gif "HUD with Cancelable"
[5.hud-popup.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/5.hud-popup.gif "HUD Popup Default"
[6.hud-popup-cancelable.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/6.hud-popup-cancelable.gif "HUD Popup with Cancelable"
[7.hud-progress.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/7.hud-progress.gif "HUD Popup with Cancelable"
[8.hud-popup-progress.gif]: https://alann-maulana.github.io/flutter_hud/example/gifs/8.hud-popup-progress.gif "HUD Popup with Cancelable"

[1.hud-default]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_default.dart
[2.hud-with-label]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_label.dart
[3.hud-with-label-detail]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_label_detail.dart
[4.hud-with-cancelable]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_cancelable.dart
[5.hud-popup]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_popup.dart
[6.hud-popup-cancelable]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_popup_cancelable.dart
[7.hud-progress]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_progress.dart
[8.hud-popup-progress]: https://github.com/alann-maulana/flutter_hud/blob/master/example/lib/hud/hud_popup_progress.dart