import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimateIcons extends StatefulWidget {
  const AnimateIcons({
    /// The IconData that will be visible before animation Starts
    @required this.startIcon,

    /// The IconData that will be visible after animation ends
    @required this.endIcon,

    /// The callback on startIcon Press
    /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    @required this.onStartIconPress,

    /// The callback on endIcon Press
    /// It should return a bool
    /// If true is returned it'll animate to the end icon
    /// if false is returned it'll not animate to the end icons
    @required this.onEndIconPress,

    /// The size of the icon that are to be shown.
    this.size,

    /// AnimateIcons controller
    this.controller,

    /// The color to be used for the [startIcon]
    this.startIconColor,

    // The color to be used for the [endIcon]
    this.endIconColor,

    /// The duration for which the animation runs
    this.duration,

    /// If the animation runs in the clockwise or anticlockwise direction
    this.clockwise,

    /// This is the tooltip that will be used for the [startIcon]
    this.startTooltip,

    /// This is the tooltip that will be used for the [endIcon]
    this.endTooltip,
  });
  final IconData startIcon, endIcon;
  final bool Function() onStartIconPress, onEndIconPress;
  final Duration duration;
  final bool clockwise;
  final double size;
  final Color startIconColor, endIconColor;
  final AnimateIconController controller;
  final String startTooltip, endTooltip;

  @override
  _AnimateIconsState createState() => _AnimateIconsState();
}

class _AnimateIconsState extends State<AnimateIcons>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    this._controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 1),
    );
    this._controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    initControllerFunctions();
    super.initState();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  bool initControllerFunctions() {
    if (widget.controller != null) {
      widget.controller.animateToEnd = () {
        if (mounted) {
          _controller.forward();
          return true;
        } else {
          return false;
        }
      };
      widget.controller.animateToStart = () {
        if (mounted) {
          _controller.reverse();
          return true;
        } else {
          return false;
        }
      };
      widget.controller.isStart = () => _controller.value == 0.0;
      widget.controller.isEnd = () => _controller.value == 1.0;
    }
    return false;
  }

  void _onStartIconPress() {
    if (widget.onStartIconPress() && mounted) _controller.forward();
  }

  void _onEndIconPress() {
    if (widget.onEndIconPress() && mounted) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final x = _controller.value ?? 0.0;
    final y = 1.0 - _controller.value ?? 0.0;
    final angleX = math.pi / 180 * (180 * x);
    final angleY = math.pi / 180 * (180 * y);

    Widget first() {
      final icon = Icon(widget.startIcon, size: widget.size);
      return Transform.rotate(
        angle: widget.clockwise ?? false ? angleX : -angleX,
        child: Opacity(
          opacity: y,
          child: IconButton(
            iconSize: widget.size ?? 24.0,
            color: widget.startIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.startTooltip == null
                ? icon
                : Tooltip(
                    message: widget.startTooltip,
                    child: icon,
                  ),
            onPressed:
                widget.onStartIconPress != null ? _onStartIconPress : null,
          ),
        ),
      );
    }

    Widget second() {
      final icon = Icon(widget.endIcon);
      return Transform.rotate(
        angle: widget.clockwise ?? false ? -angleY : angleY,
        child: Opacity(
          opacity: x ?? 0.0,
          child: IconButton(
            iconSize: widget.size ?? 24.0,
            color: widget.endIconColor ?? Theme.of(context).primaryColor,
            disabledColor: Colors.grey.shade500,
            icon: widget.endTooltip == null
                ? icon
                : Tooltip(
                    message: widget.endTooltip,
                    child: icon,
                  ),
            onPressed: widget.onEndIconPress != null ? _onEndIconPress : null,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        if (x == 1 && y == 0) second() else first(),
        if (x == 0 && y == 1) first() else second(),
      ],
    );
  }
}

class AnimateIconController {
  bool Function() animateToStart, animateToEnd;
  bool Function() isStart, isEnd;
}
