import 'package:flutter/material.dart';
import 'package:flutter_hud/src/cancel_button.dart';
import 'package:flutter_hud/src/helper.dart';
import 'package:flutter_hud/src/hud.dart';

/// A builder that builds a widget given a child.
///
/// The child should typically be part of the returned widget tree.
typedef TransitionBuilder = Widget Function(
    BuildContext context, Widget? child);

/// Class for managing progress HUD widget
class WidgetHUD extends StatelessWidget {
  /// Initialize [WidgetHUD]
  WidgetHUD({
    Key? key,
    required this.builder,
    this.child,
    this.onCancel,
    this.showHUD = false,
    this.value,
    HUD? hud,
  })  : hud = hud ??= HUD.kDefaultHUD,
        super(key: key);

  /// The template of [WidgetHUD]
  final HUD hud;

  /// Set [onCancel] to enable canceling process and dismissing progress HUD
  final VoidCallback? onCancel;

  /// The main body of [Widget] to display
  final TransitionBuilder builder;

  /// The child widget to pass to the [builder].
  ///
  /// If a [builder] callback's return value contains a subtree that does not
  /// depend on the animation, it's more efficient to build that subtree once
  /// instead of rebuilding it on every animation tick.
  ///
  /// If the pre-built subtree is passed as the [child] parameter, the
  /// [WidgetHUD] will pass it back to the [builder] function so that it
  /// can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve
  /// performance significantly in some cases and is therefore a good practice.
  final Widget? child;

  /// Flag to showing progress HUD
  final bool showHUD;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  final double? value;

  @override
  Widget build(BuildContext context) {
    if (!showHUD) {
      return builder(context, child);
    }

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      builder(context, child),
      _buildContainer(size, textTheme)
    ]);
  }

  Container _buildContainer(Size size, TextTheme textTheme) {
    final children = <Widget>[
      if (onCancel != null) const SizedBox(height: 32),
      Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.6),
        child: showOrUpdateProgressIndicator(hud, value),
      ),
      if (hud.label != null || hud.detailLabel != null)
        const SizedBox(height: 8),
      if (hud.label != null) ...{
        const SizedBox(height: 8),
        Text(hud.label!,
            style: hud.labelStyle ??
                textTheme.titleLarge!.copyWith(color: Colors.white)),
      },
      if (hud.detailLabel != null) ...{
        const SizedBox(height: 4),
        Text(hud.detailLabel!,
            style: hud.detailLabelStyle ??
                textTheme.titleSmall!.copyWith(color: Colors.white70)),
      },
      if (onCancel != null) ...{
        const SizedBox(height: 16),
        CancelButton(onCancel: onCancel!),
      },
    ];

    return Container(
      color: hud.color.withOpacity(hud.opacity),
      child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: children)),
    );
  }
}
