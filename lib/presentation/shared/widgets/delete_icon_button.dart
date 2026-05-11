import 'package:flutter/material.dart';
import 'package:my_eyes/core/utils/theme_extensions.dart';

IconButton deleteIconButton({
  required VoidCallback onPressed,
  required BuildContext context,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: const Icon(Icons.delete),
    color: context.colors.error,
    style: IconButton.styleFrom(side: BorderSide(color: context.colors.error)),
  );
}
