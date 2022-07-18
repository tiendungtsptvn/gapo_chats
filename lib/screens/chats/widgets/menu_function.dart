import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/generated/locales.g.dart';
import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MenuFunction extends GetView<ChatsController> {
  const MenuFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              const Spacer(),
              SizedBox(
                height: 44,
                child: Center(
                  child: Text(
                    LocaleKeys.chat_pick_function.tr,
                    style: textStyle(GPTypography.headingMedium)
                        ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset(
                AppPaths.iconClose,
                width: 16,
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: GPColor.linePrimary,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppPaths.iconWaitingMessage,
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                LocaleKeys.chat_waiting_message.tr,
                style: textStyle(GPTypography.bodyLarge),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: GPColor.functionNegativePrimary),
                child: Center(
                  child: Text(
                    "9",
                    textAlign: TextAlign.center,
                    style: textStyle(GPTypography.bodyMedium)?.merge(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: GPColor.functionAlwaysLightPrimary),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: (){
            controller.goToStoredConversationScreen();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppPaths.iconStoredMessage,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  LocaleKeys.chat_stored_message.tr,
                  style: textStyle(GPTypography.bodyLarge),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
