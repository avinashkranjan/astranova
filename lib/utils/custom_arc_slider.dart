import 'package:astranova/utils/arc_painter.dart';
import 'package:flutter/material.dart';

class CustomArcSlider extends StatefulWidget {
  final List<String> planets;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CustomArcSlider({
    required this.planets,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  @override
  State<CustomArcSlider> createState() => _CustomArcSliderState();
}

class _CustomArcSliderState extends State<CustomArcSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _selectPrevious();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          _selectNext();
        }
      },
      child: CustomPaint(
        size: const Size(double.infinity, 200),
        painter: ArcPainter(
          planets: widget.planets,
          selectedIndex: widget.selectedIndex,
          animation: _animation,
        ),
      ),
    );
  }

  void _selectNext() {
    if (widget.selectedIndex < widget.planets.length - 1) {
      widget.onChanged(widget.selectedIndex + 1);
      _controller.forward(from: 0);
    }
  }

  void _selectPrevious() {
    if (widget.selectedIndex > 0) {
      widget.onChanged(widget.selectedIndex - 1);
      _controller.forward(from: 0);
    }
  }
}
