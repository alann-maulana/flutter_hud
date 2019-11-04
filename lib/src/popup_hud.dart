import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_hud/src/helper.dart';

/// Class for managing progress HUD popup
class PopupHUD {
  /// Initialize [PopupHUD]
  PopupHUD(
    this.context, {
    VoidCallback onCancel,
    HUD hud,
  }) : _popupHUD = _PopupHUD(
          hud: hud ??= HUD.kDefaultHUD,
          onCancel: onCancel,
        );

  /// The [BuildContext] of [PopupHUD] progress HUD to display
  final BuildContext context;
  final _PopupHUD _popupHUD;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  double get value => _popupHUD._value;

  /// Update the displayed progress HUD value
  void setValue(double value) {
    _popupHUD.setValue(value);
  }

  /// Return progress HUD label text
  String get label => _popupHUD._label;

  /// Update the displayed progress HUD label
  void setLabel(String label) {
    _popupHUD.setLabel(label);
  }

  /// Return progress HUD detail label text
  String get detailLabel => _popupHUD._detailLabel;

  /// Update the displayed progress HUD detail label
  void setDetailLabel(String detail) {
    _popupHUD.setDetailLabel(detail);
  }

  /// Show [PopupHUD] on top of current [Navigator]
  Future<void> show() => Navigator.push(context, _popupHUD);

  /// Dismiss current showing [PopupHUD] from the top of current [Navigator]
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
  double _value;
  String _label;
  String _detailLabel;

  StateSetter _setStateValue, _setStateLabel, _setStateDetailLabel;

  @override
  Color get barrierColor => _hud.color.withOpacity(_hud.opacity);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final size = MediaQuery.of(context).size;

    final children = <Widget>[
      Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.6),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          _setStateValue = setState;

          return showOrUpdateProgressIndicator(_hud, _value);
        }),
      ),
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

  void setValue(double value) {
    assert(value == null || (value >= 0 && value <= 1.0));
    if (_setStateValue != null) {
      _setStateValue(() {
        this._value = value;
      });
    }
  }

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
