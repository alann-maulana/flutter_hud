import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:flutter_hud/src/cancel_button.dart';
import 'package:flutter_hud/src/helper.dart';

/// Class for managing progress HUD popup
class PopupHUD {
  /// Initialize [PopupHUD]
  PopupHUD(this.context, {VoidCallback? onCancel, HUD? hud})
      : _popupHUD = _PopupHUD(hud: hud ??= HUD.kDefaultHUD, onCancel: onCancel);

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
  double? get value => _popupHUD._value.value;

  /// Update the displayed progress HUD value
  void setValue(double value) => _popupHUD.setValue(value);

  /// Return progress HUD label text
  String? get label => _popupHUD._label.value;

  /// Update the displayed progress HUD label
  void setLabel(String label) => _popupHUD.setLabel(label);

  /// Return progress HUD detail label text
  String? get detailLabel => _popupHUD._detailLabel.value;

  /// Update the displayed progress HUD detail label
  void setDetailLabel(String detail) => _popupHUD.setDetailLabel(detail);

  /// Show [PopupHUD] on top of current [Navigator]
  Future<void> show() => Navigator.push(context, _popupHUD);

  /// Dismiss current showing [PopupHUD] from the top of current [Navigator]
  bool dismiss() {
    Navigator.pop(context);
    return true;
  }
}

class _PopupHUD extends ModalRoute<void> {
  _PopupHUD({
    this.onCancel,
    required HUD hud,
  }) : _hud = hud {
    _label = ValueNotifier(_hud.label);
    _detailLabel = ValueNotifier(_hud.detailLabel);
    _value = ValueNotifier(null);
  }

  final VoidCallback? onCancel;
  final HUD _hud;
  late final ValueNotifier<double?> _value;
  late final ValueNotifier<String?> _label;
  late final ValueNotifier<String?> _detailLabel;

  @override
  Color get barrierColor => _hud.color.withOpacity(_hud.opacity);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final children = <Widget>[
      Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.6),
        child: ValueListenableBuilder<double?>(
          valueListenable: _value,
          builder: (context, value, child) => showOrUpdateProgressIndicator(_hud, value),
        ),
      ),
      if (_showLabel) ...{
        const SizedBox(height: 16),
        ValueListenableBuilder<String?>(
          valueListenable: _label,
          builder: (context, label, child) {
            return Text(label!, style: _hud.labelStyle ?? textTheme.titleLarge!.copyWith(color: Colors.white));
          },
        ),
      },
      if (_showDetailLabel) ...{
        const SizedBox(height: 4.0),
        ValueListenableBuilder<String?>(
          valueListenable: _detailLabel,
          builder: (context, detailLabel, child) {
            return Text(
              detailLabel!,
              style: _hud.detailLabelStyle ?? textTheme.titleSmall!.copyWith(color: Colors.white70),
            );
          },
        ),
      },
      if (onCancel != null) ...{
        const SizedBox(height: 16),
        CancelButton(onCancel: () => canceled(context)),
      },
    ];

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Center(
          child: _hud.decoration != null
              ? Container(decoration: _hud.decoration, padding: _hud.padding, child: column)
              : column,
        ),
      ),
    );
  }

  void canceled(BuildContext context) {
    Navigator.pop(context);
    if (onCancel != null) onCancel!();
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  bool get _showLabel => _label.value != null && _label.value!.isNotEmpty;

  bool get _showDetailLabel => _detailLabel.value != null && _detailLabel.value!.isNotEmpty;

  void setValue(double? value) {
    assert(value == null || (value >= 0 && value <= 1.0));
    _value.value = value;
  }

  void setLabel(String label) => _label.value = label;

  void setDetailLabel(String detail) => _detailLabel.value = detail;
}
