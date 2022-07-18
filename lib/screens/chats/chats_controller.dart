import 'dart:async';

import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/configs/path.dart';
import 'package:base_flutter/generated/locales.g.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/routes/routes.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatsController extends BaseController {
  final ChatAPI _chatAPI = ChatAPI();

  RxList chats = [].obs;
  RxString error = "".obs;

  List<ChatModel> _chatsStored = [];
  String _currentKeyword = "";
  Timer? _debounceSearch;
  int _currentPage = 1;

  @override
  void onClose() {
    if (_debounceSearch != null) {
      _debounceSearch!.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() {
    initChats();
    super.onInit();
  }

  void initChats() async {
    isLoading.value = true;
    await _getChats();
    isLoading.value = false;
  }

  Future<void> _getChats() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<ChatModel> res = await _chatAPI.getChats(page: _currentPage);
      if (_currentKeyword.trim().isNotEmpty) {
        if (_currentPage == 1) {
          chats.value = res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList();
        } else {
          chats.addAll(res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList());
        }
      } else {
        if (_currentPage == 1) {
          chats.value = res;
          _chatsStored = res;
        } else {
          chats.addAll(res);
          _chatsStored.addAll(res);
        }
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: GPColor.workPrimary,
        messageText: Text(
          LocaleKeys.chat_errorNotification.tr,
          style: textStyle(GPTypography.bodyMedium)
              ?.merge(const TextStyle(color: GPColor.contentInversePrimary)),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<dynamic> onReload() async {
    _currentPage = 1;
    await _getChats();
  }

  Future<dynamic> onLoadMore() async {
    _currentPage += 1;
    await _getChats();
  }

  void onchangeSearch({required String keyword}) {
    if (_debounceSearch?.isActive ?? false) {
      _debounceSearch?.cancel();
    }
    _debounceSearch = Timer(const Duration(milliseconds: 500), () {
      _searchByKeyword(keyword: keyword);
    });
  }

  void _searchByKeyword({required String keyword}) {
    if (keyword.trim().isEmpty) {
      chats.value = _chatsStored;
      return;
    }
    _currentKeyword = keyword;
    List<ChatModel> result = [];
    for (ChatModel chat in _chatsStored) {
      if (chat.nameContains(keyword: keyword)) {
        result.add(chat);
      }
    }
    chats.value = result;
    return;
  }

  void removeChat({required int index}) {
    actionCanUndo(
        listItem: chats,
        index: index,
        undoMessage: LocaleKeys.chat_delete_success.tr,
        action: () {
          printInfo(info: "Call api remove chat");
        });
  }

  void storeConversation({required int index}) {
    Get.back();
    actionCanUndo(
        listItem: chats,
        index: index,
        undoMessage: LocaleKeys.chat_store_success.tr,
        action: () {
          printInfo(info: "Call api store conversation");
        });
  }

  void goToStoredConversationScreen() async {
    Get.back();
    bool reloadChats = await Get.toNamed(RouterName.storedConversation);
    if (reloadChats) {
      _currentPage = 1;
      await _getChats();
    }
  }

  static void actionCanUndo(
      {required RxList listItem,
      required int index,
      required String undoMessage,
      required Function action}) {
    final storedList = [];
    storedList.addAll(listItem);
    bool acted = false;
    listItem.removeAt(index);
    Get.closeCurrentSnackbar();
    Get.showSnackbar(GetSnackBar(
      backgroundColor: GPColor.bgInversePrimary,
      icon: SvgPicture.asset(AppPaths.iconDone),
      messageText: Text(
        undoMessage,
        style: textStyle(GPTypography.bodyMedium)
            ?.merge(const TextStyle(color: GPColor.contentInversePrimary)),
      ),
      duration: const Duration(seconds: Constants.restoreSnackDuration),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      mainButton: SizedBox(
        width: 98,
        child: Row(
          children: [
            Container(
              width: 1,
              height: 20,
              color: GPColor.functionAlwaysLightPrimary.withOpacity(0.3),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                acted = true;
                Get.closeCurrentSnackbar();
                listItem.value = storedList;
              },
              child: Text(
                LocaleKeys.chat_undo.tr,
                style: textStyle(GPTypography.headingSmall)?.merge(
                    const TextStyle(
                        color: GPColor.functionAccentWorkSecondary)),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    )).future.then((value) {
      if (!acted) {
        action();
      }
    });
  }
}
