import 'package:flutter/material.dart';

class TextFieldComp extends StatelessWidget {
  final String infoText;
  final TextEditingController controller;
  final bool isVerify;
  final void Function(String)? onChanged;
  final int? maxLines;

  const TextFieldComp({
    super.key,
    required this.infoText,
    required this.controller,
    required this.isVerify,
    this.onChanged,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            infoText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor:
              isVerify ? const Color(0xFF37DA00) : const Color(0xFFC90000),
          cursorWidth: 1,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isVerify
                    ? const Color(0xFF37DA00)
                    : const Color(0xFF4E4A4B),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isVerify
                    ? const Color(0xFF37DA00)
                    : const Color(0xFF4E4A4B),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isVerify
                    ? const Color(0xFF37DA00)
                    : const Color(0xFFC90000),
              ),
            ),
            suffixIcon: isVerify ? const Icon(Icons.check) : const SizedBox(),
            hintStyle: const TextStyle(fontSize: 16),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 2,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
