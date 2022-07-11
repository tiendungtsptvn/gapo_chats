import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/configs/string.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyConversations extends StatelessWidget {
  const EmptyConversations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppPaths.iconConversations,
          fit: BoxFit.fill,
          width: 80,
          height: 80,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          AppStrings.emptyConversations,
          style: textStyle(GPTypography.headingLarge)?.merge(
            const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
