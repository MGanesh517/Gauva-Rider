import 'package:flutter/material.dart';

void customModalSheet(
    BuildContext context, {
      required Widget minimizeWidget,
      required Widget maximizeWidget,
    }) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableModalSheet(
        minimizeWidget: minimizeWidget,
        maximizeWidget: maximizeWidget,
      ),
  );
}

class DraggableModalSheet extends StatefulWidget {
  final Widget minimizeWidget;
  final Widget maximizeWidget;

  const DraggableModalSheet({
    super.key,
    required this.minimizeWidget,
    required this.maximizeWidget,
  });

  @override
  State<DraggableModalSheet> createState() => _DraggableModalSheetState();
}

class _DraggableModalSheetState extends State<DraggableModalSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double minHeight = 100; // minimized height
  double maxHeight = 500; // maximized height

  double currentHeight = 100;

  @override
  void initState() {
    super.initState();
    currentHeight = minHeight;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0.0, // 0 = minimized, 1 = maximized
    );
  }

  void animateTo(double target) {
    _controller.animateTo(target, curve: Curves.easeInOut);
  }

  void onDragUpdate(DragUpdateDetails details) {
    final double delta = details.primaryDelta ?? 0;
    setState(() {
      currentHeight -= delta;
      if (currentHeight < minHeight) currentHeight = minHeight;
      if (currentHeight > maxHeight) currentHeight = maxHeight;

      // update controller value from height
      _controller.value = (currentHeight - minHeight) / (maxHeight - minHeight);
    });
  }

  void onDragEnd(DragEndDetails details) {
    // Decide whether to minimize or maximize based on drag velocity and position
    if (_controller.value > 0.5) {
      animateTo(1.0);
      setState(() {
        currentHeight = maxHeight;
      });
    } else {
      animateTo(0.0);
      setState(() {
        currentHeight = minHeight;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isMaximized => _controller.value > 0.5;

  @override
  Widget build(BuildContext context) => Stack(
      children: [
        // Outside tap detect but don't dismiss
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              debugPrint('Outside tap detected but modal stays open.');
            },
            child: const SizedBox(),
          ),
        ),

        // Sheet draggable container
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final height = minHeight + _controller.value * (maxHeight - minHeight);
            return Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragUpdate: onDragUpdate,
                onVerticalDragEnd: onDragEnd,
                child: Container(
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: isMaximized ? widget.maximizeWidget : widget.minimizeWidget,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
}

