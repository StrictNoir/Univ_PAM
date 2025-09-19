import 'package:flutter/material.dart';

class CollapsiblePanel extends StatelessWidget {
  const CollapsiblePanel({
    super.key,
    required this.items,
    this.scale = 1,
  });

  final List<CollapsibleItem> items;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    return Column(
      children: [
        _DividerLine(scale: scale),
        for (final item in items) ...[
          SizedBox(
            height: sx(48),
            child: InkWell(
              onTap: item.onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sx(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: sx(16),
                        height: 1,
                        color: const Color(0xFF222222),
                      ),
                    ),
                    Transform.rotate(
                      angle: -1.5708,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: sx(16),
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _DividerLine(scale: scale),
        ],
      ],
    );
  }
}

class CollapsibleItem {
  final String title;
  final VoidCallback? onTap;
  const CollapsibleItem(this.title, {this.onTap});
}

class _DividerLine extends StatelessWidget {
  const _DividerLine({this.scale = 1});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .25,
      child: Divider(
        color: const Color(0xFF9B9B9B),
        thickness: .4 * scale,
        height: 0,
      ),
    );
  }
}