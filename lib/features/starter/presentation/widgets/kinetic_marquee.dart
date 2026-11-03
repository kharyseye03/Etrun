import 'package:flutter/material.dart';

/// Bandeau de texte géant qui défile en boucle, en fond d'écran.
class KineticMarquee extends StatefulWidget {
  const KineticMarquee({
    super.key,
    required this.text,
    required this.style,
    this.reverse = false,
    this.duration = const Duration(seconds: 18),
  });

  final String text;
  final TextStyle style;
  final bool reverse;
  final Duration duration;

  @override
  State<KineticMarquee> createState() => _KineticMarqueeState();
}

class _KineticMarqueeState extends State<KineticMarquee>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: widget.duration)
    ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Largeur d'un motif : on la mesure pour boucler sans à-coup.
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final width = painter.width;

    return ClipRect(
      child: SizedBox(
        height: painter.height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            final t = widget.reverse ? 1 - _controller.value : _controller.value;
            return OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.centerLeft,
              child: Transform.translate(offset: Offset(-t * width, 0), child: child),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 3; i++)
                Text(widget.text, style: widget.style, maxLines: 1, softWrap: false),
            ],
          ),
        ),
      ),
    );
  }
}
