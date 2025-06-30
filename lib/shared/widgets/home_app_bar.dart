import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/style_constant.dart';
import '../constants/text_constant.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Platform.isIOS ? statusBarHeight : preferredSize.height / 2,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 0.5,
            ),
          ],
        ),
        height: preferredSize.height + (Platform.isIOS ? statusBarHeight : preferredSize.height / 2),
        alignment: Alignment.center,
        child: Text(gutenread, style: subTitleRedStyle),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
