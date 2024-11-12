import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String infoText;
  final TextEditingController controller;
  final bool isVerify;
  final void Function(String) onChanged;

  const PasswordField({
    super.key,
    required this.infoText,
    required this.controller,
    required this.isVerify,
    required this.onChanged,
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
          obscureText: true,
          onChanged: onChanged,
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
