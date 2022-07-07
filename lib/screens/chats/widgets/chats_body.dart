import 'package:base_flutter/base/widgets/base_smart_refresher_v2.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/screens/chats/widgets/chat_item.dart';
import 'package:base_flutter/screens/chats/widgets/chat_tabs.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatsBody extends GetView<ChatsController> {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsChats.length,
      initialIndex: 0,
      child: Builder(
        builder: (BuildContext context) {
          return Flexible(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                  child: ChatTabs(),
                ),
                Flexible(
                    child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(tabsChats.length, (index) {
                    return Obx(() {
                      List<dynamic> chats = [];
                      if (controller.chats.isEmpty &&
                          controller.loadingChats.value) {
                        chats =
                            List.generate(10, (index) => ChatModel()).toList();
                      } else {
                        chats = controller.chats;
                      }
                      return (chats.isEmpty)
                          ? const Center(
                              child: Text("Empty"),
                            )
                          : BaseSmartFresherV2(
                              child: ListView.builder(
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                      key: Key((chats[index] as ChatModel)
                                          .id
                                          .toString()),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.45,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: 80,
                                                color: GPColor.bgTertiary,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/images/icon-more.svg",
                                                      color: GPColor
                                                          .contentPrimary,
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      "Thêm",
                                                      style: textStyle(
                                                              GPTypography
                                                                  .bodySmall)
                                                          ?.merge(
                                                        const TextStyle(
                                                            color: GPColor
                                                                .contentPrimary),
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
                                                color: GPColor
                                                    .functionNegativePrimary,
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/images/icon-recycle-bin.svg",
                                                      color: GPColor
                                                          .contentInversePrimary,
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Text(
                                                      "Xóa",
                                                      style: textStyle(
                                                              GPTypography
                                                                  .bodySmall)
                                                          ?.merge(
                                                        const TextStyle(
                                                            color: GPColor
                                                                .contentInversePrimary),
                                                      ),
                                                    )
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                ),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                      child: ChatItem(
                                        loading: controller.loadingChats.value,
                                        chat: chats[index] as ChatModel,
                                      ));
                                },
                              ),
                              onRefresh: controller.onReload,
                              onLoadMore: controller.onLoadMore,
                            );
                    });
                  }),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
