import 'package:flutter/material.dart';

import '../theme.dart';

class SizeDropdown extends StatelessWidget {
  const SizeDropdown({
    super.key,
    required this.sizes,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  final List<String> sizes;
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final borderColor = showError ? const Color(0xFFF01F0E) : AppColors.gray;
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Size',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.black, width: 1.2),
        ),
        errorText: showError ? 'Please select a size' : null,
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.black),
      items: sizes
          .map(
            (size) => DropdownMenuItem<String>(
          value: size,
          child: Text(size, style: Theme.of(context).textTheme.bodyMedium),
        ),
      )
          .toList(),
      onChanged: onChanged,
    );
  }
}