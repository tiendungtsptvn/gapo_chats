import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatsController extends BaseController {
  final ChatAPI _chatAPI = ChatAPI();

  RxList chats = [].obs;
  RxBool loadingChats = false.obs;
  RxBool loadingMore = false.obs;
  RxString error = "".obs;

  int currentPage = 1;

  bool get isError => error.value.isNotEmpty;

  bool get canLoadMore => chats.length >= (currentPage * Constants.perPageSize);

  void initChats()async{
    loadingChats.value = true;
    await getChats();
    loadingChats.value = false;
  }
  Future<void> getChats() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<ChatModel> res = await _chatAPI.getChats(
          page: currentPage);
      if(currentPage == 1){
        chats.value = res;
      }else{
        chats.addAll(res);
      }
    } catch (_) {}
  }

  bool pinned({required ChatModel? chat}) {
    if (chat?.pinnedCount != null) {
      if (chat!.pinnedCount! > 0) {
        return true;
      }
    }
    return false;
  }

  bool isActive({required ChatModel? chat}) {
    if (chat?.enableNotify != null) {
      if (chat!.enableNotify == 1) {
        return true;
      }
    }
    return false;
  }

  bool enableUnread({required ChatModel? chat}) {
    if (chat?.unreadCount != null) {
      if (chat!.unreadCount! > 0) {
        return true;
      }
    }
    return false;
  }

  String getTimeLastMessage({required ChatModel? chat}) {
    DateTime time = DateTime.now();
    DateTime now = DateTime.now();
    if (chat?.lastMessage?.createdAt != null) {
      time = DateTime.fromMillisecondsSinceEpoch(chat!.lastMessage!.createdAt!);
      if (now.difference(time).inSeconds < 60) {
        return "Vừa xong";
      } else if (now.difference(time).inMinutes < 60) {
        return "${now.difference(time).inMinutes} phút";
      } else if (now.difference(time).inHours < 24) {
        return "${now.difference(time).inHours} giờ";
      } else {
        return DateFormat("dd TMM").format(time);
      }
    }
    return "";
  }

  int getUnreadMessage({required ChatModel? chat}) {
    if (enableUnread(chat: chat)) {
      if (chat!.unreadCount! > 9) {
        return 9;
      } else {
        return chat.unreadCount!;
      }
    }
    return 0;
  }

  Future<dynamic> onReload() async {
    currentPage = 1;
    await getChats();
  }

  Future<dynamic> onLoadMore() async {
    currentPage += 1;
    await getChats();
  }
}
