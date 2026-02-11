
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();

    return ElevatedButton(
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      style: buttonStyle,
      child: _buildButtonChild(),
    );
  }

  ButtonStyle _getButtonStyle() {
    final backgroundColor = _getBackgroundColor();
    final foregroundColor = _getTextColor();

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: _getBorder(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: variant == ButtonVariant.primary ? 2 : 0,
    );
  }

  Color _getBackgroundColor() {
    if (isDisabled) return Colors.grey[300]!;

    return switch (variant) {
      ButtonVariant.primary => const Color(0xFF00AAE4),
      ButtonVariant.secondary => Colors.white,
      ButtonVariant.outlined => Colors.transparent,
    };
  }

  Color _getTextColor() {
    if (isDisabled) return Colors.grey[500]!;

    return switch (variant) {
      ButtonVariant.primary => Colors.white,
      ButtonVariant.secondary => const Color(0xFF00AAE4),
      ButtonVariant.outlined => const Color(0xFF00AAE4),
    };
  }

  BorderSide _getBorder() {
    if (isDisabled) return BorderSide(color: Colors.grey[400]!);

    return switch (variant) {
      ButtonVariant.primary => BorderSide.none,
      ButtonVariant.secondary => BorderSide(color: Colors.grey[300]!),
      ButtonVariant.outlined => const BorderSide(
        color: Color(0xFF00AAE4),
        width: 1,
      ),
    };
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }

    if (icon == null) {
      return Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

enum ButtonVariant { primary, secondary, outlined }
