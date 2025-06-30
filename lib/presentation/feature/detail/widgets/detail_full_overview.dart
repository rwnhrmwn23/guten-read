import 'package:flutter/material.dart';

import '../../../../shared/constants/style_constant.dart';
import '../../../../shared/constants/text_constant.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: defaultStyle);

        final tp = TextPainter(
          text: span,
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
          ellipsis: threeDot,
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
                          TextSpan(text: readLess, style: readMoreStyle),
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
                              TextSpan(text: threeDot),
                              TextSpan(text: readMore, style: readMoreStyle),
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
    var readMoreText = readMoreContent;
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
