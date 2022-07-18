import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/generated/locales.g.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/screens/chats/stored_conversation/stored_conversation_controller.dart';
import 'package:base_flutter/screens/chats/widgets/chat_item.dart';
import 'package:base_flutter/screens/chats/widgets/chat_item_loading.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DismissibleStoredConversationItem
    extends GetView<StoredConversationController> {
  const DismissibleStoredConversationItem({
    Key? key,
    required this.chat,
    required this.index,
  }) : super(key: key);
  final ChatModel chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (chat.isLoading()) {
      return const ChatItemLoading();
    }
    return Slidable(
      key: Key((chat.id != null) ? chat.id.toString() : ""),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.45,
        children: [
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.restoreStoredConversation(index: index);
              },
              child: Container(
                width: 80,
                color: GPColor.bgTertiary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppPaths.iconRestore,
                      color: GPColor.contentPrimary,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      LocaleKeys.chat_restore.tr,
                      style: textStyle(GPTypography.bodySmall)?.merge(
                        const TextStyle(color: GPColor.contentPrimary),
                      ),
                    )
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.removeStoredConversation(index: index);
              },
              child: Container(
                width: 80,
                color: GPColor.functionNegativePrimary,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppPaths.iconRecycleBin,
                      color: GPColor.contentInversePrimary,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      LocaleKeys.chat_delete.tr,
                      style: textStyle(GPTypography.bodySmall)?.merge(
                        const TextStyle(color: GPColor.contentInversePrimary),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
      child: ChatItem(chat: chat),
    );
  }
}
