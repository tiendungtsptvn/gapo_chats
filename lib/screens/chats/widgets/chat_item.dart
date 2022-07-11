import 'package:base_flutter/base/widgets/animated_shimmer.dart';
import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/configs/string.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatItem extends GetView<ChatsController> {
  const ChatItem({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    if (chat.isLoading()) {
      return SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //avatar
            const AnimatedShimmer(width: 64, height: 64, radius: 100),
            //content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AnimatedShimmer(width: 150, height: 12),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedShimmer(width: 250, height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Slidable(
      key: Key((chat.id != null) ? chat.id.toString() : ""),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.45,
        children: [
          const SizedBox(width: 12,),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 80,
                color: GPColor.bgTertiary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppPaths.iconMore,
                      color: GPColor.contentPrimary,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      AppStrings.more,
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
                      AppStrings.delete,
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
      child: SizedBox(
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
                      chat.avatar ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return const Image(
                          image: AssetImage(AppPaths.defaultImage),
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
                  if (chat.isActive())
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: GPColor.workPrimary,
                          border:
                              Border.all(width: 1, color: GPColor.bgPrimary),
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
                            chat.name ?? "",
                            style: (chat.enableUnread())
                                ? textStyle(GPTypography.headingMedium)?.merge(
                                    const TextStyle(
                                        fontWeight: FontWeight.bold))
                                : textStyle(GPTypography.bodyLarge),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (chat.isPinned())
                          const SizedBox(
                            width: 10,
                          ),
                        if (chat.isPinned())
                          SvgPicture.asset(
                            AppPaths.iconFilledPin,
                          ),
                        if (chat.enableUnread())
                          const SizedBox(
                            width: 10,
                          ),
                        if (chat.enableUnread())
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GPColor.functionAccentWorkSecondary),
                            child: Center(
                              child: Text(
                                chat.getUnreadMessage().toString(),
                                style: textStyle(GPTypography.bodySmallBold)
                                    ?.merge(const TextStyle(
                                        color: GPColor
                                            .functionAlwaysLightPrimary)),
                              ),
                            ),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.lastMessage?.body ?? "",
                            style: textStyle(GPTypography.bodyMedium)?.merge(
                                (chat.enableUnread())
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
                            chat.getTimeLastMessage(),
                            style: textStyle(GPTypography.bodyMedium)?.merge(
                              const TextStyle(color: GPColor.contentSecondary),
                            ),
                            textAlign: TextAlign.end,
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
      ),
    );
  }
}
