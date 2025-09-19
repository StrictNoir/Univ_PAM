import 'package:flutter/material.dart';

import '../theme.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    this.initialIsFavorite = false,
    this.onChanged,
    this.size = 36,
  });

  final bool initialIsFavorite;
  final ValueChanged<bool>? onChanged;
  final double size;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialIsFavorite;
  }

  void _toggle() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onChanged?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.size);
    final icon = _isFavorite ? Icons.favorite : Icons.favorite_border;
    final iconColor = _isFavorite ? AppColors.primary : AppColors.gray;

    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: _toggle,
        customBorder: RoundedRectangleBorder(borderRadius: borderRadius),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Icon(icon, color: iconColor, size: widget.size * 0.6),
        ),
      ),
    );
  }
}