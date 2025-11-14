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
    final defaultCount = items.length <= 2 ? items.length : items.length - 2;
    final boxedItems = items.length <= 2 ? const <CollapsibleItem>[] : items.sublist(items.length - 2);
    return Column(
      children: [
        if (defaultCount > 0) ...[
          _DividerLine(scale: scale),
          for (int i = 0; i < defaultCount; i++) ...[
            _FlatTile(item: items[i], scale: scale),
            _DividerLine(scale: scale),
          ],
        ],
        if (boxedItems.isNotEmpty) ...[
          if (defaultCount > 0) SizedBox(height: sx(16)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sx(16)),
            child: Column(
              children: [
                for (int i = 0; i < boxedItems.length; i++) ...[
                  _BoxedTile(item: boxedItems[i], scale: scale),
                  if (i != boxedItems.length - 1) SizedBox(height: sx(8)),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _FlatTile extends StatelessWidget {
  const _FlatTile({required this.item, required this.scale});

  final CollapsibleItem item;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    return SizedBox(
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
    );
  }
}

class _BoxedTile extends StatelessWidget {
  const _BoxedTile({required this.item, required this.scale});

  final CollapsibleItem item;
  final double scale;

  @override
  Widget build(BuildContext context) {
    double sx(double value) => value * scale;
    final borderRadius = BorderRadius.circular(sx(8));
    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: borderRadius,
        child: Container(
          height: sx(56),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: const Color(0x1A000000),
              width: sx(1),
            ),
          ),
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