import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 0.5,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Guten Read',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDE7773),
            fontFamily: 'AvenirNext',
          ),
        )
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
