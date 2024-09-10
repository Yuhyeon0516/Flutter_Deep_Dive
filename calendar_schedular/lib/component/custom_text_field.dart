import 'package:calendar_schedular/const/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String? initialValue;

  const CustomTextField({
    super.key,
    required this.label,
    this.expand = false,
    required this.onSaved,
    required this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!expand) renderTextFormField(),
        if (expand)
          Expanded(
            child: renderTextFormField(),
          ),
      ],
    );
  }

  renderTextFormField() {
    return TextFormField(
      expands: expand,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      cursorColor: Colors.grey,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
    );
  }
}
