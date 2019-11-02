import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';

class PopupHUD {
  PopupHUD(
    this.context, {
    VoidCallback onCancel,
    HUD hud,
  }) : _popupHUD = _PopupHUD(
          hud: hud ??= HUD.kDefaultHUD,
          onCancel: onCancel,
        );

  final BuildContext context;
  final _PopupHUD _popupHUD;

  void setLabel(String label) {
    _popupHUD.setLabel(label);
  }

  void setDetailLabel(String detail) {
    _popupHUD.setDetailLabel(detail);
  }

  Future<void> show() => Navigator.push(context, _popupHUD);

  bool dismiss() => Navigator.pop(context);
}

class _PopupHUD extends ModalRoute<void> {
  _PopupHUD({
    this.onCancel,
    HUD hud,
  }) : _hud = hud ??= HUD.kDefaultHUD {
    this._label = _hud.label;
    this._detailLabel = _hud.detailLabel;
  }

  final VoidCallback onCancel;
  final HUD _hud;
  String _label;
  String _detailLabel;

  StateSetter _setStateLabel, _setStateDetailLabel;

  @override
  Color get barrierColor => _hud.color.withOpacity(_hud.opacity);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final children = <Widget>[
      _hud.progressIndicator,
      if (_showLabel) SizedBox(height: 8),
      if (_showLabel) SizedBox(height: 8),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        _setStateLabel = setState;

        if (_showLabel) {
          return Text(
            _label,
            style: _hud.labelStyle ??
                Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    ),
          );
        }

        return SizedBox.shrink();
      }),
      if (_showDetailLabel) SizedBox(height: 4.0),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        _setStateDetailLabel = setState;

        if (_showDetailLabel) {
          return Text(
            _detailLabel,
            style: _hud.detailLabelStyle ??
                Theme.of(context).textTheme.subtitle.copyWith(
                      color: Colors.white70,
                    ),
          );
        }

        return SizedBox.shrink();
      }),
      if (onCancel != null) SizedBox(height: 16),
      if (onCancel != null)
        (Platform.isIOS || Platform.isMacOS)
            ? CupertinoButton(
                child: Text('Cancel'),
                onPressed: () => canceled(context),
              )
            : FlatButton(
                child: Text('Cancel'),
                textTheme: ButtonTextTheme.primary,
                onPressed: () => canceled(context),
              ),
    ];

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: new Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }

  void canceled(BuildContext context) {
    Navigator.pop(context);
    if (onCancel != null) {
      onCancel();
    }
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  bool get _showLabel => _label != null && _label.isNotEmpty;

  bool get _showDetailLabel => _detailLabel != null && _detailLabel.isNotEmpty;

  void setLabel(String label) {
    if (_setStateLabel != null) {
      _setStateLabel(() {
        this._label = label;
      });
    }
  }

  void setDetailLabel(String detail) {
    if (_setStateLabel != null) {
      _setStateDetailLabel(() {
        this._detailLabel = detail;
      });
    }
  }
}
