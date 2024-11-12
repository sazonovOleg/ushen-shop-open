import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBtn extends StatelessWidget {
  final String btnText;
  final String iconPath;
  final void Function() onTap;
  final bool disabled;

  const AppBtn({
    super.key,
    required this.btnText,
    required this.iconPath,
    required this.onTap,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !disabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: !disabled
              ? const Color(0xFF4E4A4B)
              : const Color(0xFF4E4A4B).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: .5,
            color: const Color(0xFFCCCCCC),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              btnText,
              style: const TextStyle(color: Colors.white),
            ),
            SvgPicture.asset(
              iconPath,
              width: 38,
              height: 38,
            ),
          ],
        ),
      ),
    );
  }
}
