import 'dart:async';

import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/configs/string.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsController extends BaseController {
  final ChatAPI _chatAPI = ChatAPI();

  RxList chats = [].obs;
  RxString error = "".obs;

  List<ChatModel> chatsStored = [];
  String _currentKeyword = "";
  Timer? _debounceSearch;
  int currentPage = 1;

  bool get isError => error.value.isNotEmpty;

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
      List<ChatModel> res = await _chatAPI.getChats(page: currentPage);
      if (_currentKeyword.trim().isNotEmpty) {
        if (currentPage == 1) {
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
        if (currentPage == 1) {
          chats.value = res;
          chatsStored = res;
        } else {
          chats.addAll(res);
          chatsStored.addAll(res);
        }
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: GPColor.workPrimary,
        messageText: Text(
          AppStrings.errorNotification,
          style: textStyle(GPTypography.bodyMedium)
              ?.merge(const TextStyle(color: GPColor.contentInversePrimary)),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<dynamic> onReload() async {
    currentPage = 1;
    await _getChats();
  }

  Future<dynamic> onLoadMore() async {
    currentPage += 1;
    await _getChats();
  }

  void onchangeSearch({required String? keyword}) {
    if (_debounceSearch?.isActive ?? false) {
      if (_debounceSearch != null) {
        _debounceSearch!.cancel();
      }
    }
    _debounceSearch = Timer(const Duration(milliseconds: 500), () {
      _searchByKeyword(keyword: keyword);
    });
  }

  void _searchByKeyword({required String? keyword}) {
    if (keyword != null) {
      _currentKeyword = keyword;
      if (keyword.trim().isNotEmpty) {
        List<ChatModel> result = [];
        for (ChatModel chat in chatsStored) {
          if (chat.nameContains(keyword: keyword)) {
            result.add(chat);
          }
        }
        chats.value = result;
        return;
      }
    }
    chats.value = chatsStored;
  }
}
