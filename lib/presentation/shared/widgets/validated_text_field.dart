import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_eyes/core/validators/field_validator.dart';

class ValidatedTextField extends StatefulWidget {
  const ValidatedTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.onValidationChanged,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.showInlineError = true,
    this.onErrorChanged,
  });

  final TextEditingController controller;
  final FieldValidator validator;
  final ValueChanged<bool> onValidationChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool showInlineError;
  final ValueChanged<String?>? onErrorChanged;

  @override
  State<ValidatedTextField> createState() => _ValidatedTextFieldState();
}

class _ValidatedTextFieldState extends State<ValidatedTextField> {
  String? _errorText;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (!_isDirty) setState(() => _isDirty = true);

    final result = widget.validator.validate(widget.controller.text);
    final isValid = result is ValidationValid;

    final newError = switch (result) {
      ValidationValid() => null,
      ValidationInvalid(:final message) => message,
    };

    if (newError != _errorText) {
      setState(() => _errorText = newError);
      widget.onValidationChanged(isValid);
      if (!widget.showInlineError) {
        widget.onErrorChanged?.call(newError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.showInlineError
            ? (_isDirty ? _errorText : null)
            : (_isDirty && _errorText != null ? '' : null),
        errorStyle: widget.showInlineError
            ? null
            : const TextStyle(fontSize: 0, height: 0),
      ),
    );
  }
}
