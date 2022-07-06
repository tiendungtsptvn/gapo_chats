import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ChatTabs extends StatefulWidget {
  const ChatTabs({Key? key}) : super(key: key);

  @override
  State<ChatTabs> createState() => _ChatTabsState();
}

class _ChatTabsState extends State<ChatTabs> {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    _tabController = DefaultTabController.of(context)!;

    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: List.generate(
          tabsChats.length,
          (index) => Text(
                tabsChats[index],
                maxLines: 1,
              )),
      labelColor: GPColor.workPrimary,
      unselectedLabelColor: GPColor.contentSecondary,
      indicatorColor: GPColor.workPrimary,
      indicatorPadding: EdgeInsets.zero,
      labelStyle: textStyle(GPTypography.headingMedium),
      // labelPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      onTap: (visit) async {
      },
    );
  }
}

final List<String> tabsChats = ["Tất cả", "Nhắc đến", "Chưa đọc", "Product"];
