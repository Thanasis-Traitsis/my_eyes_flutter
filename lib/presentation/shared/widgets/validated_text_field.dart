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
  });

  final TextEditingController controller;
  final FieldValidator validator;
  final ValueChanged<bool> onValidationChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

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
        errorText: _isDirty ? _errorText : null,
      ),
    );
  }
}
