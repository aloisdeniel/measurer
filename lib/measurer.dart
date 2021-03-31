library measurer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Measure the size of its [child].
///
/// The [onMeasure] callback is called after each new rendering of its child.
class Measurer extends SingleChildRenderObjectWidget {
  /// Create a new measurer.
  ///
  /// The given [onMeasure] callback is called after each new rendering of its
  /// child and provides its layout size.
  ///
  /// The given [onPaintBoundsChanged] callback is called after each new rendering of its
  /// child and provides its paint bounds on the screen.
  const Measurer({
    Key? key,
    this.onMeasure,
    this.onPaintBoundsChanged,
    required Widget child,
  }) : super(key: key, child: child);

  /// A callback that is called after each new rendering of its child and provides
  /// its layout size.
  final OnMeasure? onMeasure;

  /// A callback that is called after each new rendering of its child and provides
  /// its paint bounds on the screen.
  final OnPaintBoundsChanged? onPaintBoundsChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(
      onMeasure: onMeasure,
      onPaintBoundsChanged: onPaintBoundsChanged,
    );
  }
}

/// When a [size] or its associated [constraints] changed.
typedef OnMeasure = void Function(
  Size size,
  BoxConstraints? constraints,
);

/// When the onscreen [paintBounds] changed.
typedef OnPaintBoundsChanged = void Function(
  Rect paintBounds,
);

/// An element that notifies whenever its size changes.
class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject({
    required this.onMeasure,
    required this.onPaintBoundsChanged,
  });

  final OnMeasure? onMeasure;
  final OnPaintBoundsChanged? onPaintBoundsChanged;

  Size? _size;
  BoxConstraints? _constraints;
  Rect? _paintBounds;

  @override
  void performLayout() {
    super.performLayout();

    var measureChanged = false;
    var paintBoundsChanged = false;

    final newSize = child?.size ?? Size.zero;
    if (_size != newSize) {
      _size = newSize;
      measureChanged = true;
    }

    final newConstraints = child?.constraints;
    if (_constraints != newConstraints) {
      _constraints = newConstraints;
      measureChanged = true;
    }

    final newPaintBounds = child?.paintBounds ?? Rect.zero;
    if (_paintBounds != newPaintBounds) {
      _paintBounds = newPaintBounds;
      paintBoundsChanged = true;
    }

    measureChanged = onMeasure != null && measureChanged;
    paintBoundsChanged = onPaintBoundsChanged != null && paintBoundsChanged;

    if (measureChanged || paintBoundsChanged) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (measureChanged) {
          onMeasure!.call(
            _size!,
            _constraints,
          );
        }
        if (paintBoundsChanged) {
          onPaintBoundsChanged!.call(
            _paintBounds!,
          );
        }
      });
    }
  }
}
