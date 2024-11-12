import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;

  const AppBarComponent({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: const Image(
        image: AssetImage('images/logo.png'),
        width: 140,
        height: 28,
      ),
      backgroundColor: const Color(0xFF4C4C4D),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
