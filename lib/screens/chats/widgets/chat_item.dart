import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatItem extends GetView<ChatsController> {
  const ChatItem({Key? key, required this.chat}) : super(key: key);
  final ChatModel? chat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //avatar
          SizedBox(
            height: 64,
            width: 64,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    chat?.avatar ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage("assets/images/default_image.png"),
                        height: 64,
                        width: 64,
                        fit: BoxFit.fill,
                      );
                    },
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                  ),
                ),
                if (controller.isActive(chat: chat))
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GPColor.workPrimary,
                        border: Border.all(width: 1, color: GPColor.bgPrimary),
                      ),
                    ),
                  )
              ],
            ),
          ),
          //content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          chat?.name ?? "",
                          style: (controller.enableUnread(chat: chat))
                              ? textStyle(GPTypography.headingMedium)?.merge(
                                  const TextStyle(fontWeight: FontWeight.bold))
                              : textStyle(GPTypography.bodyLarge),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (controller.pinned(chat: chat))
                        const SizedBox(
                          width: 10,
                        ),
                      if (controller.pinned(chat: chat))
                        SvgPicture.asset(
                          "assets/images/icon-filled-pin.svg",
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (controller.enableUnread(chat: chat))
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: GPColor.functionAccentWorkSecondary),
                          child: Center(
                            child: Text(
                              controller
                                  .getUnreadMessage(chat: chat)
                                  .toString(),
                              style: textStyle(GPTypography.bodySmallBold)
                                  ?.merge(const TextStyle(
                                      color:
                                          GPColor.functionAlwaysLightPrimary)),
                            ),
                          ),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat?.lastMessage?.body ?? "",
                          style: textStyle(GPTypography.bodyMedium)?.merge(
                              (controller.enableUnread(chat: chat))
                                  ? const TextStyle(
                                      color: GPColor.contentPrimary,
                                      fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      color: GPColor.contentSecondary,
                                    )),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 65,
                        child: Text(
                          controller.getTimeLastMessage(chat: chat),
                          style: textStyle(GPTypography.bodyMedium)?.merge(
                              const TextStyle(color: GPColor.contentSecondary)),
                          maxLines: 1,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}