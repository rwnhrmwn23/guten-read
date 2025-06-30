import 'package:flutter/material.dart';

import '../../../../shared/constants/text_constant.dart';

class HomeBookError extends StatelessWidget {
  final String? errorText;

  const HomeBookError({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        errorText.toString(),
        style: TextStyle(fontFamily: fontFamilyApp),
      ),
    );
  }
}
