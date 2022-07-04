import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';


class SearchChats extends StatelessWidget {
  const SearchChats({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholderStyle: textStyle(GPTypography.body16),
      textInputAction: TextInputAction.next,
      restorationId: 'email_address_text_field',
      placeholder: "Tìm kiếm",
      style: textStyle(GPTypography.body16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 13, right: 10),
        child: SvgPicture.asset(
          AppPaths.searchIcon,
          color: GPColor.hintTextInput,
          fit: BoxFit.fill,
          width: 13,
          height: 13,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: GPColor.textFieldBkg,
        borderRadius: BorderRadius.circular(20),
      ),
      autocorrect: false,
    );
  }
}
