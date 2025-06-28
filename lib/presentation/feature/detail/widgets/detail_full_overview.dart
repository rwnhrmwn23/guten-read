import 'package:flutter/material.dart';

class DetailFullOverview extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;

  const DetailFullOverview({
    super.key,
    required this.text,
    this.trimLines = 7,
    this.style,
  });

  @override
  State<DetailFullOverview> createState() => _ReadMoreInlineState();
}

class _ReadMoreInlineState extends State<DetailFullOverview>
    with TickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        widget.style ??
        TextStyle(
          fontSize: 15,
          color: Colors.grey[600],
          fontFamily: 'AvenirNext',
        );

    final readMoreStyle = const TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.w600,
      fontFamily: 'AvenirNext',
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: defaultStyle);

        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
          ellipsis: '...',
        );

        tp.layout(maxWidth: constraints.maxWidth);

        final overflows = tp.didExceedMaxLines;

        if (!_expanded && !overflows) {
          return Text(widget.text, style: defaultStyle);
        }

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child:
                _expanded
                    ? Text.rich(
                      TextSpan(
                        text: widget.text,
                        style: defaultStyle,
                        children: [
                          TextSpan(text: ' Read less', style: readMoreStyle),
                        ],
                      ),
                    )
                    : Builder(
                      builder: (_) {
                        final trimmedText = _trimTextToFit(
                          widget.text,
                          constraints.maxWidth,
                          defaultStyle,
                        );
                        return RichText(
                          text: TextSpan(
                            style: defaultStyle,
                            children: [
                              TextSpan(text: trimmedText),
                              const TextSpan(text: '... '),
                              TextSpan(text: 'Read more', style: readMoreStyle),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        );
      },
    );
  }

  String _trimTextToFit(String text, double maxWidth, TextStyle style) {
    const readMoreText = '... Read more';
    final textPainter = TextPainter(
      text: TextSpan(text: text + readMoreText, style: style),
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    if (!textPainter.didExceedMaxLines) return text;

    int end = text.length;
    int start = 0;

    while (start < end) {
      final mid = (start + end) ~/ 2;
      final current = TextPainter(
        text: TextSpan(
          text: text.substring(0, mid) + readMoreText,
          style: style,
        ),
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
      );
      current.layout(maxWidth: maxWidth);

      if (current.didExceedMaxLines) {
        end = mid;
      } else {
        start = mid + 1;
      }
    }

    return text.substring(0, end - 1);
  }
}
