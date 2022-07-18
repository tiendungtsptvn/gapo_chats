import 'dart:convert';

import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/chat.dart';
import 'package:flutter/services.dart';

class ChatAPI {
  //have no api
  Future<List<ChatModel>> getChats({required int page}) async {
    List<ChatModel> chats = [];
    //get local sample data instead of call api
    try {
      final data = await _loadDataFromAsset(
        path: 'assets/sample_data/chat_response.json',
      );
      if (data["data"] != null) {
        List<dynamic> list = data["data"];
        for (int index = 0; index < list.length; index++) {
          //handle for load more without api
          if (index >= ((page - 1) * Constants.perPageSize) &&
              index < ((page) * Constants.perPageSize)) {
            chats.add(ChatModel.fromJson(list[index] as Map<String, dynamic>));
          }
          if (chats.length == Constants.perPageSize) {
            break;
          }
        }
      }
      return chats;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatModel>> getStoredConversations({required int page}) async {
    List<ChatModel> storedConversations = [];
    //get local sample data instead of call api
    try {
      final data = await _loadDataFromAsset(
        path: 'assets/sample_data/stored_conversation.json',
      );
      if (data["data"] != null) {
        List<dynamic> list = data["data"];
        for (int index = 0; index < list.length; index++) {
          //handle for load more without api
          if (index >= ((page - 1) * Constants.perPageSize) &&
              index < ((page) * Constants.perPageSize)) {
            storedConversations
                .add(ChatModel.fromJson(list[index] as Map<String, dynamic>));
          }
          if (storedConversations.length == Constants.perPageSize) {
            break;
          }
        }
      }
      return storedConversations;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> _loadDataFromAsset({required String path}) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }
}
