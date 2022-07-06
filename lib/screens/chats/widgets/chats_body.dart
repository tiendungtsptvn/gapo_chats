import 'package:base_flutter/base/widgets/base_smart_refresher_v2.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/screens/chats/widgets/chat_item.dart';
import 'package:base_flutter/screens/chats/widgets/chat_tabs.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsBody extends GetView<ChatsController> {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return SizedBox();
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
                      if (controller.loadingChats.value) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      return BaseSmartFresherV2(
                        child: ListView.builder(
                          itemCount: controller.chats.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              crossAxisEndOffset: 0.5,
                              background: Container(
                                width: 20,
                                alignment: AlignmentDirectional.centerEnd,
                                color: GPColor.functionNegativePrimary,
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              child: ChatItem(
                                chat: controller.chats[index] as ChatModel,
                              ),
                            );
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
          // return Scaffold(
          //   appBar: AppBar(
          //     bottom: const PreferredSize(
          //       preferredSize: Size.fromHeight(42),
          //       child: ChatTabs(),
          //     ),
          //   ),
          //   body: TabBarView(
          //     physics: const NeverScrollableScrollPhysics(),
          //     children: List.generate(tabsChats.length, (index) {
          //       return SingleChildScrollView(
          //         child: SizedBox(
          //           height: 100,
          //         ),
          //       );
          //     }),
          //   ),
          // );
        },
      ),
    );
  }
}
