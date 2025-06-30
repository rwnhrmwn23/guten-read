import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        padding: EdgeInsets.only(top: Platform.isIOS ? statusBarHeight : preferredSize.height / 2),
        height: preferredSize.height + (Platform.isIOS ? statusBarHeight : preferredSize.height / 2),
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
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {
            context.pop('/')
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}